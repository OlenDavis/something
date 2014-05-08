angoolar.addConfigBlock class AppConfig extends angoolar.StatefulConfigBlock

	$_dependencies: [ '$urlRouterProvider', '$locationProvider', '$animateProvider', '$sceDelegateProvider' ]

	constructor: ->
		super

		@$urlRouterProvider.otherwise '/us/things/'

		@$animateProvider.classNameFilter /s-animate-/

		whitelist = @$sceDelegateProvider.resourceUrlWhitelist()
		whitelist.push 'https://www.youtube.com/**'
		whitelist.push 'https://i.ytimg.com/**'
		@$sceDelegateProvider.resourceUrlWhitelist whitelist

	setupStates: ->
		@addState 'site',
			abstract   : yes
			url        : '/{language:[a-z]{2}}/'
			templateUrl: 'site.html'

		@addState 'things',
			parent     : 'site'
			url        : 'things/'
			templateUrl: 'things.html'
			controller : angoolar.ThingsController

		@addState 'stuff',
			parent     : 'site'
			url        : 'stuff/'
			templateUrl: 'stuff.html'
			controller : angoolar.StuffController
