angoolar.addFactory angoolar.State = class State extends angoolar.BaseFactory
	$_name: 'State'

	$_autoAttachToDependency: '$rootScope'

	constructor: ->
		super

		@$page = null

		@$languages = [ 'us', 'ru' ]

	initialize: ->
		@$rootScope.$on '$stateChangeStart',   @stateChangeBegun
		@$rootScope.$on '$stateChangeSuccess', @stateChangeFinished
		@$rootScope.$on '$stateChangeError',   @stateChangeFinished

		@$rootScope.$watch '$stateParams.language', ( newLanguage, oldLanguage ) => @$language = newLanguage if newLanguage isnt oldLanguage
			
		@$rootScope.$watch ( => @$language ), =>
			return unless @$language?
			@$rootScope.$stateParams.language = @$language
			@$rootScope.$state.transitionTo(
				@$rootScope.$state.current
				@$rootScope.$stateParams
				{
					reload : yes
					inherit: no
					notify : yes
				}
			)

		@$rootScope.$watch '$stateParams.language', ( newLanguage, oldLanguage ) => @$language = newLanguage

	stateChangeBegun   : => @$stateChanging = yes
	stateChangeFinished: => @$stateChanging = no

	updatedPage            : ( @$page ) =>
	updatedLocalizedStrings: ( @$localizedStrings ) =>