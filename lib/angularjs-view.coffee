{View} = require 'atom'

module.exports =
class AngularjsView extends View
  @content: ->
    @div class: 'angularjs overlay from-top', =>
      @div "The Angularjs package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "angularjs:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "AngularjsView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
