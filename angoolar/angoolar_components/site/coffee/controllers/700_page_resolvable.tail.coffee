angoolar.PageResolvable = class PageResolvable extends angoolar.BaseResolvable
	$_name: 'PageResolvable'

	$_dependencies: [
		angoolar.StateManager
		'$timeout'
	]

	resolve: -> @StateManager.$stats.pendingResults
