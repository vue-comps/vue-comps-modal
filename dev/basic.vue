<template lang="pug">
.container(style="padding:40px")
  button click
    modal(v-ref:modal, v-bind:style="style")
      p Content
  button(@click="toggle") not dismissable
  modal(not-dismissable, ignore-parent,v-ref:notDismissable,v-bind:is-opened.sync="isOpened", v-bind:style="style")
    p Content
    button(@click.prevent="toggle") close
  br
  a(href="https://github.com/vue-comps/vue-comps-modal/blob/master/dev/basic.vue") source
</template>

<script lang="coffee">
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
</script>
