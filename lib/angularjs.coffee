AngularjsView = require './angularjs-view'

module.exports =
  angularjsView: null

  activate: (state) ->
    @angularjsView = new AngularjsView(state.angularjsViewState)

  deactivate: ->
    @angularjsView.destroy()

  serialize: ->
    angularjsViewState: @angularjsView.serialize()
