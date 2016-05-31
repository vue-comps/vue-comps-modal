// out: ..
<template lang="jade">
div(
  v-el:modal
  v-bind:class="classes"
  v-bind:style="style"
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
  ]

  created: ->
    @overlay = require("vue-overlay")(@Vue)

  props:
    "class":
      type: String
      default: "modal"
    "opacity":
      type: Number
      default: 0.5
    "notDismissable":
      type: Boolean
      default: false
    "transitionIn":
      type: Function
      default: ({el,cb}) ->
        @style.opacity = 1
        cb()
    "transitionOut":
      type: Function
      default: ({el,cb}) ->
        @style.opacity = 0
        cb()

  data: ->
    classes: [@class]
    closeOverlay: null
    style:
      opacity: 0
      position: "fixed"
      left: 0
      right: 0
      zIndex: 1000
      display: "block"

  events:
    close: ->
      @close()
      return true
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
      {zIndex,close} = @overlay.open dismissable:!@notDismissable, opacity:@opacity, onBeforeClose: => @close()
      @style.zIndex = zIndex
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
        @open()
      else
        @close()
</script>
