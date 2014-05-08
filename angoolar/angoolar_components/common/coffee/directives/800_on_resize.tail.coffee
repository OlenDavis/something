alreadyLoaded = ( $image ) ->
	$image.complete or
	$image.width() isnt 0 or
	$image.height() isnt 0

angular.element.fn.imagesLoaded = ( stats ) ->
	$images = this.find 'img'
	$images.add this if 'img' is this.prop( 'tagName' ).toLowerCase()
	
	$images.each ->
		$image = angular.element this

		stats.addPending()

		loaded = -> stats.pendingResolved $image

		if alreadyLoaded $image
			loaded()
		else
			$image.on 'load', loaded

	this

angoolar.addDirective class OnResize extends angoolar.BaseDirective
	$_name: 'OnResize'

	$_dependencies: [ '$parse', '$injector' ]

	# evaluates the directive attribute with locals of 'width' and 'height' as the pixel count of the element's width and height

	link: ( $scope, $element, $attrs ) ->
		super

		imageLoadedStats = new angoolar.Stats @$injector

		onResizeGetter = @$parse $attrs[ @$_makeName() ]

		# unless angoolar.isBrowser.Mobile
		onResize = ( size ) ->
			onResizeGetter $scope,
				width : size?.width  or $element.outerWidth()
				height: size?.height or $element.outerHeight()

		angoolar.$window.resize -> $scope.$root.$apply onResize

		setTimeout -> $scope.$root.$apply onResize

		$scope.$watch(
			->
				width : $element.outerWidth()
				height: $element.outerHeight()

			onResize

			yes
		)

		$scope.$on '$stateChangeSuccess', -> setTimeout -> $scope.$root.$apply ->
			$element.imagesLoaded imageLoadedStats
			imageLoadedStats.pendingResults.finally onResize # re-apply the onResize expression when all/any images have loaded
