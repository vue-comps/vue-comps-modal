// out: ..
<template lang="jade">
.vc-modal(
  v-bind:style="style"
  v-if="opened"
  @keyup.esc="dismiss | notPrevented | prevent"
  @click="doNothing | notPrevented | prevent"
  )
  slot No content
</template>

<script lang="coffee">
module.exports =

  mixins: [
    require("vue-mixins/getVue")
  ]

  filters:
    notPrevented: require("vue-filters/notPrevented")
    prevent: require("vue-filters/prevent")

  created: ->
    @overlay = require("vue-overlay")(@getVue())

  props:
    "opacity":
      type: Number
      default: 0.5
    "dismissable":
      type: Boolean
      default: true
    "isOpened":
      type:Boolean
      default: false
    "fadeIn":
      type: Function
      default: ({el,cb}) ->
        @style.opacity = 1
        cb()
    "fadeOut":
      type: Function
      default: ({el,cb}) ->
        @style.opacity = 0
        cb()
    "parent":
      type: Object
    "onClick":
      type: Boolean
      default: true

  data: ->
    opened: false
    closeOverlay: null
    removeParentClickListener: null
    style:
      opacity: 0
      position: "fixed"
      left: 0
      right: 0
      zIndex: 1000

  watch:
    "parent": "setupParent"
    "isOpened": (val) ->
      if val != @opened
        if val
          @open()
        else
          @close()
  events:
    close: ->
      @close()
      return true
  methods:
    doNothing: ->

    dismiss: ->
      @close() if @dismissable

    show: ->
      @opened = true
      @isOpened = true
      #@$appendTo document.body
      @$nextTick =>
        @$emit "beforeOpen"
        @fadeIn el:@$el, cb: =>
          @$emit "opened"
    hide: ->
      return unless @opened
      @$emit "beforeClose"
      @fadeIn el:@$el, cb: =>
        @opened = false
        @isOpened = false
        @$emit "closed"
    open: ->
      return if @opened
      {zIndex,close} = @overlay.open dismissable:@dismissable, opacity:@opacity, onClosed: => @close()
      @style.zIndex = zIndex
      @closeOverlay = close
      @show()
    close: ->
      @closeOverlay?()
      @closeOverlay = null
      @hide()
    onParentClick: (e) ->
      return if e.defaultPrevented
      if @opened
        @close()
      else
        @open()
      e.preventDefault()
    setupParent: (parent = @parent) ->
      if @onClick
        @removeParentClickListener?()
        parent.addEventListener "click", @onParentClick
        @removeParentClickListener = =>
          parent.removeEventListener "click", @onParentClick

  attached: ->
    unless @parent?
      @parent = @$el.parentElement
    else
      @setupParent()
</script>
