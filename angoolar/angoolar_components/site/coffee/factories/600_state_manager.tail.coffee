angoolar.addFactory angoolar.StateManager = class StateManager extends angoolar.BaseFactory
	$_name: 'StateManager'

	$_autoAttachToDependency: '$rootScope'

	$_dependencies: [
		angoolar.State
		'$injector'
		'$timeout'
	]

	constructor: ->
		super

		@$pages = {}

		@$stats = new angoolar.Stats @$injector

	initialize: ->
		@$rootScope.$on '$stateChangeStart', ( event, toState, toParams ) => @updateState toState, toParams

	updateState: ( state, params ) ->
		@updatePath @$rootScope.$state.href state, params, relative: state # will be e.g. /en/home (WHEN HTML5 is available), #/en/home (for older browsers)

		return unless @$path?.length

		@updatePage()

	$pathRegex: /#?\/([a-z]{2})\/([^\/\?]+)(\/([^\/\?]+))?/
	updatePath: ( path ) ->
		return if not path? or path is @$path or path is 'null'

		return unless @$pathRegex.test path

		# OMG, LOOK MA!! DESTRUCTURED ASSIGNMENT!!
		[ @$path, @$language, @$page, remainder... ] = path.match @$pathRegex

	updatePage: ->
		unless @$pages[ @$path ]?

			@$stats.addPending()
			@$timeout( ( -> ), 1000 ).then =>
				@$pages[ @$path ] = {}
				@$stats.pendingResolved()
		else
			# don't update the page on State if the request for the page hasn't finished yet
			@State.updatedPage @$pages[ @$path ] unless @$stats.pendingCount
