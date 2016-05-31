<template lang="jade">
.container
  button click
    modal
      p Content
  button not dismissable
    modal(not-dismissable)
      p Content
      closer
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
.container > a
  position absolute
  left 250px
  top 40px
.modal
  background white
  width 80%
  height 60%
  margin auto
</style>
