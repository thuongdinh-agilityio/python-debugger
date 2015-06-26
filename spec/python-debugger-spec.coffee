PythonDebugger = require '../lib/python-debugger'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "PythonDebugger", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('python-debugger')

  describe "when the python-debugger:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.python-debugger')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'python-debugger:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.python-debugger')).toExist()

        pythonDebuggerElement = workspaceElement.querySelector('.python-debugger')
        expect(pythonDebuggerElement).toExist()

        pythonDebuggerPanel = atom.workspace.panelForItem(pythonDebuggerElement)
        expect(pythonDebuggerPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'python-debugger:toggle'
        expect(pythonDebuggerPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.python-debugger')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'python-debugger:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        pythonDebuggerElement = workspaceElement.querySelector('.python-debugger')
        expect(pythonDebuggerElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'python-debugger:toggle'
        expect(pythonDebuggerElement).not.toBeVisible()
