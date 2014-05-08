angoolar.addFactory angoolar.StateManager = class StateManager extends angoolar.BaseFactory
	$_name: 'StateManager'

	$_autoAttachToDependency: '$rootScope'

	$_dependencies: [
		angoolar.State
		'$injector'
		'$timeout'
		'$log'
	]

	constructor: ->
		super

		@$pages            = {}
		@$localizedStrings = {}

		@$stats = new angoolar.Stats @$injector

	initialize: ->
		@$rootScope.$on '$stateChangeStart', ( event, toState, toParams ) => @updateState toState, toParams

	updateState: ( state, params ) ->
		@updatePath @$rootScope.$state.href state, params, relative: state # will be e.g. /en/home (WHEN HTML5 is available), #/en/home (for older browsers)

		return unless @$path?.length

		@updatePage()
		@updateLocalizedStrings()

	$pathRegex: /#?\/([a-z]{2})\/([^\/\?]+)(\/([^\/\?]+))?/
	updatePath: ( path ) ->
		return if not path? or path is @$path or path is 'null'

		return unless @$pathRegex.test path

		# OMG, LOOK MA!! DESTRUCTURED ASSIGNMENT!!
		[ @$path, @$language, @$page, remainder... ] = path.match @$pathRegex

	updatePage: ->
		unless @$pages[ @$path ]?

			pageDelay = Math.ceil Math.random() * 1000

			@$stats.addPending()
			@$timeout( ( -> {} ), pageDelay ).then ( page ) =>
				@$log.debug "#{ @$path } took #{ pageDelay }ms to load"
				@State.updatedPage @$pages[ @$path ] = page
				@$stats.pendingResolved()
		else
			# don't update the page on State if the request for the page hasn't finished yet
			@State.updatedPage @$pages[ @$path ] unless @$pages[ @$path ]?.$_stats?.pendingCount

	updateLocalizedStrings: ->
		unless @$localizedStrings[ @$language ]?

			localizedStringsDelay = Math.ceil Math.random() * 1000
		
			@$stats.addPending()
			@$timeout( ( -> {} ), localizedStringsDelay ).then ( localizedStrings ) =>
				@$log.debug "#{ @$language } took #{ localizedStringsDelay }ms to load"
				@State.updatedLocalizedStrings @$localizedStrings[ @$language ] = localizedStrings
				@$stats.pendingResolved()
		else
			# don't update the localizedStrings on State if the request for the localizedStrings hasn't finished yet
			@State.updatedLocalizedStrings @$localizedStrings[ @$language ] unless @$localizedStrings[ @$language ]?.$_stats?.pendingCount
