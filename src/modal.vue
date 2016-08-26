// out: ..
<template lang="pug">
div(
  v-el:modal
  v-bind:class="computedClass"
  v-bind:style="computedStyle"
  v-if="opened"
  @keyup.esc="dismiss"
  @click.prevent="doNothing"
  )
  slot No content
</template>

<script lang="coffee">
module.exports =

  mixins: [
    require("vue-mixins/vue")
    require("vue-mixins/isOpened")
    require("vue-mixins/parentListener")
    require("vue-mixins/style")
    require("vue-mixins/class")
  ]

  created: ->
    @overlay = require("vue-overlay")(@Vue)
  computed:
    mergeClass: -> []
  props:
    "class":
      default: -> []
    "style":
      default: -> []
    "opacity":
      type: Number
      default: 0.5
    "notDismissable":
      type: Boolean
      default: false
    "transitionIn":
      type: Function
      default: ({el,cb}) ->
        @mergeStyle.opacity = 1
        cb()
    "transitionOut":
      type: Function
      default: ({el,cb}) ->
        @mergeStyle.opacity = 0
        cb()
    "zIndex":
      type: Number
      coerce: Number
      default: 1500

  data: ->
    closeOverlay: null
    mergeStyle:
      opacity: 0
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
      @$appendTo document.body
      @$nextTick =>
        @$emit "beforeOpen"
        @transitionIn el:@$els.modal, cb: =>
          @$emit "opened"
    hide: ->
      return unless @opened
      @$emit "beforeClose"
      @transitionOut el:@$els.modal, cb: =>
        @setClosed()
        @$emit "closed"
        @$remove()
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
</script>
