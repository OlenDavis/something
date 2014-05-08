class App extends angoolar.BaseModule
	$_name: '/* @echo name */'

	$_dependencies: [ 'ui.router', 'ngResource', 'ngSanitize', 'ngAnimate' ]

angoolar.addModule App
angoolar.setTargetModule App