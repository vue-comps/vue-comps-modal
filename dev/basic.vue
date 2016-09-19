<template lang="pug">
.container(style="padding:40px")
  button click
    modal(v-ref:modal, v-bind:style="style")
      p Content
  button(@click="toggle") not dismissable
  modal(not-dismissable, ignore-parent,v-ref:notDismissable,v-bind:is-opened.sync="isOpened", v-bind:style="style")
    p Content
    button(@click.prevent="toggle") close
  button with custom transition
    modal(v-bind:style="style" transition="modal2")
      p Content
  br
  a(href="https://github.com/vue-comps/vue-comps-modal/blob/master/dev/basic.vue") source
</template>

<script lang="coffee">
Velocity = require("velocity-animate")
module.exports =
  components:
    "modal" : require "../src/modal.vue"
  data: ->
    isOpened: false
    style:
      background: "white"
      width: "80%"
      height: "60%"
      margin: "auto"
      padding: "20px"
      top: "20%"
  methods:
    toggle: ->
      @isOpened = !@isOpened
  transitions:
    modal2:
      css: false
      enter: (el,done) ->
        Velocity.hook el, "scale", "0.4"
        Velocity.hook el, "translateY", "-100%"
        Velocity el, {opacity: 1,scale: 1,translateY: 0}, {
          duration: 1000
          queue: false
          complete: done
        }
      enterCancelled: (el) ->
        Velocity el, "stop"
      leave: (el,done) ->
        Velocity el, {opacity: 0,scale:0.4,translateY:"-100%"}, {
          duration: 1000
          queue: false
          complete: done
        }
      leaveCancelled: (el) ->
        Velocity el, "stop"
</script>
