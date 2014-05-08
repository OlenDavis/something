angoolar.addFactory angoolar.State = class State extends angoolar.BaseFactory
	$_name: 'State'

	$_autoAttachToDependency: '$rootScope'

	constructor: ->
		super

		@$page = null

	initialize: ->
		@$rootScope.$on '$stateChangeStart',   @stateChangeBegun
		@$rootScope.$on '$stateChangeSuccess', @stateChangeFinished
		@$rootScope.$on '$stateChangeError',   @stateChangeFinished

	stateChangeBegun   : => @$stateChanging = yes
	stateChangeFinished: => @$stateChanging = no

	updatedPage: ( @$page ) =>