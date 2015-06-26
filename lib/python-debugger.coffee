PythonDebuggerView = require './python-debugger-view'
{CompositeDisposable} = require 'atom'

module.exports = PythonDebugger =
  pythonDebuggerView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @pythonDebuggerView = new PythonDebuggerView(state.pythonDebuggerViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @pythonDebuggerView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'python-debugger:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @pythonDebuggerView.destroy()

  serialize: ->
    pythonDebuggerViewState: @pythonDebuggerView.serialize()

  toggle: ->
    console.log 'PythonDebugger was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
