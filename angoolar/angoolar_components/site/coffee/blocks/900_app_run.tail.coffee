angoolar.addRunBlock class AppRun extends angoolar.StatefulRunBlock

	$_dependencies: [ angoolar.State, angoolar.StateManager ]

	constructor: ->
		super

		@State.initialize()

		@StateManager.initialize()