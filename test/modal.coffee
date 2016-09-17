env = null
mouseClick = ->
  evt = document.createEvent("MouseEvents")
  evt.initMouseEvent(
    "click",
    true,
    true,
    window,
    1,
    10,
    10,
    10,
    10,
    false,
    false,
    false,
    false,
    0,
    null
    )
  return evt

describe "modal", ->

  describe "basic env", ->

    before ->
      env = loadComp(require("../dev/basic.vue"))

    after ->
      #unloadComp(env)

    it "should work", (done) ->
      should.not.exist env.$refs.modal.$els.modal
      should.not.exist env.$refs.notdismissable.$els.modal
      env.$refs.modal.isOpened = true
      env.$nextTick -> env.$nextTick ->
        should.exist env.$refs.modal.$els.modal
        len = document.body.children.length
        document.body.children[len-1].should.have.attr("style").match /z-index: 1501/
        document.body.children[len-2].should.have.attr("style").match /z-index: 1500/
        env.$refs.notdismissable.isOpened = true
        env.$nextTick -> env.$nextTick ->
          should.exist env.$refs.notdismissable.$els.modal
          len = document.body.children.length
          document.body.children[len-1].should.have.attr("style").match /z-index: 1506/
          document.body.children[len-3].should.have.attr("style").match /z-index: 1505/
          document.dispatchEvent(mouseClick())
          env.$nextTick -> env.$nextTick ->
            env.$refs.notdismissable.isOpened.should.be.true
            env.$refs.notdismissable.isOpened = false
            env.$nextTick -> env.$nextTick ->
              should.not.exist env.$refs.notdismissable.$els.modal
              len = document.body.children.length
              document.body.children[len-2].should.have.attr("style").match /z-index: 1500/
              document.body.children[len-2].dispatchEvent(mouseClick())
              env.$nextTick ->
                should.not.exist env.$refs.modal.$els.modal
                done()
