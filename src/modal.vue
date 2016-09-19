// out: ..
<template lang="pug">
div(
  v-el:modal
  v-bind:class="computedClass"
  v-bind:style="computedStyle"
  v-if="opened"
  @keyup.esc="dismiss"
  @click.prevent="doNothing"
  v-bind:transition="cTransition"
  )
  slot
</template>

<script lang="coffee">
module.exports =

  mixins: [
    require("vue-mixins/vue")
    require("vue-mixins/isOpened")
    require("vue-mixins/parentListener")
    require("vue-mixins/style")
    require("vue-mixins/class")
    require("vue-mixins/transition")
  ]

  created: ->
    @overlay = require("vue-overlay")(@Vue)
  computed:
    mergeClass: -> []
  props:
    class:
      default: -> []
    style:
      default: -> []
    opacity:
      type: Number
      default: 0.5
      coerce: Number
    notDismissable:
      type: Boolean
      default: false
    zIndex:
      type: Number
      coerce: Number
      default: 1500
    transition:
      type: String
      default: "modal"

  data: ->
    closeOverlay: null
    mergeStyle:
      position: "fixed"
      left: 0
      right: 0
      zIndex: 1000
      display: "block"

  methods:
    doNothing: ->

    dismiss: (e) ->
      return if e.defaultPrevented
      e.preventDefault()
      @close() unless @notDismissable

    show: ->
      @setOpened()
      @$nextTick =>
        document.body.appendChild @$els.modal

    hide: ->
      return unless @opened
      @setClosed()

    open: ->
      return if @opened
      {zIndex,close} = @overlay.open zIndex:@zIndex, dismissable:!@notDismissable, opacity:@opacity, onBeforeClose: => @close()
      @mergeStyle.zIndex = zIndex
      @closeOverlay = close
      @show()
    close: ->
      @hide()
      @closeOverlay?()
      @closeOverlay = null

    onParentClick: (e) ->
      return if e.defaultPrevented
      if @opened
        @close()
      else
        @open()
      e.preventDefault()
    toggle: ->
      if @opened
        @close()
      else
        @open()

  beforeDestroy: ->
    el = @$els.modal
    if el?
      el.parentNode.removeChild(el)
</script>
