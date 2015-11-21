AhkSyntaxHighlightingView = require './ahk-syntax-highlighting-view'
{CompositeDisposable} = require 'atom'

module.exports = AhkSyntaxHighlighting =
  ahkSyntaxHighlightingView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @ahkSyntaxHighlightingView = new AhkSyntaxHighlightingView(state.ahkSyntaxHighlightingViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @ahkSyntaxHighlightingView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ahk-syntax-highlighting:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @ahkSyntaxHighlightingView.destroy()

  serialize: ->
    ahkSyntaxHighlightingViewState: @ahkSyntaxHighlightingView.serialize()

  toggle: ->
    console.log 'AhkSyntaxHighlighting was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
