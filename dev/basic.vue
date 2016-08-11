<template lang="pug">
.container(style="padding:40px")
  button click
    modal.modal
      p Content
  button not dismissable
    modal.modal(not-dismissable)
      p Content
      closer
  br
  a(href="https://github.com/vue-comps/vue-comps-modal/blob/master/dev/basic.vue") source
</template>

<script lang="coffee">
module.exports =
  components:
    "modal" : require "../src/modal.vue"
    "closer":
      template: "<button @click.prevent='close'>close</button>"
      methods:
        close: ->
          @$dispatch "close"
</script>

<style lang="stylus">
.modal
  background white
  width 80%
  height 60%
  margin auto
  top: 20%
</style>
