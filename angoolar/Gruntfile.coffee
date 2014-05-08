module.exports = ( grunt ) ->

	###
	This would take a src object of the form:
	{
		something:
			totally: "else"
		and: "this"
	}
	And extend the dest object with the following:
	{
		something_totally: "else"
		and: "this"
	}
	###
	flatExtend = ( dest, src, keyPath ) ->
		if typeof src is 'object'
			for key, value of src
				flatExtend( dest, value, ( keyPath and "#{ keyPath }_" or '' ) + key )
		else
			dest[ keyPath ] = src

		dest

	packageJson = grunt.file.readJSON 'package.json'

	prepHtmlTarget =
		expand : yes
		flatten: yes
		src    : [ '<%= pkg.htmlTarget %>' ]
		dest   : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/'

	prepCoffee =
		expand : yes
		flatten: yes
		src    : [ '**/<%= pkg.coffeeDir %>/**/*.coffee', '!node_modules/**/*', '!<%= pkg.buildDir %>/**/*' ]
		dest   : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.coffeeDir %>/'

	prepJs =
		expand : yes
		flatten: yes
		src    : [ '**/<%= pkg.jsDir %>/**/*.js', '!node_modules/**/*', '!<%= pkg.buildDir %>/**/*' ]
		dest   : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.jsDir %>/'

	prepCss =
		expand : yes
		flatten: yes
		src    : [ '**/<%= pkg.cssDir %>/**/*.css', '!node_modules/**/*', '!<%= pkg.buildDir %>/**/*' ]
		dest   : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.cssDir %>/'

	prepFonts =
		expand : yes
		flatten: yes
		src    : [ '**/<%= pkg.fontsDir %>/**/*', '!node_modules/**/*', '!<%= pkg.buildDir %>/**/*' ]
		dest   : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.fontsDir %>/'

	prepImages =
		expand : yes
		flatten: yes
		src    : [ '**/<%= pkg.imagesDir %>/**/*', '!node_modules/**/*', '!<%= pkg.buildDir %>/**/*' ]
		dest   : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.imagesDir %>/'

	prepDirectiveTemplates =
		expand : yes
		flatten: yes
		src    : [ '**/<%= pkg.templatesDir %>/<%= pkg.directivesDir %>/*.html', '!node_modules/**/*', '!<%= pkg.buildDir %>/**/*' ]
		dest   : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.templatesDir %>/<%= pkg.directivesDir %>/'

	prepViewTemplates =
		expand : yes
		flatten: yes
		src    : [ '**/<%= pkg.templatesDir %>/<%= pkg.viewsDir %>/*.html', '!node_modules/**/*', '!<%= pkg.buildDir %>/**/*' ]
		dest   : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.templatesDir %>/<%= pkg.viewsDir %>/'

	prepScss =
		expand : yes
		src    : [ '**/<%= pkg.scssDir %>/**/*.scss', '!node_modules/**/*', '!<%= pkg.buildDir %>/**/*' ]
		dest   : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.scssDir %>'

	buildCoffeeHead = 
		expand : yes
		flatten: yes
		src    : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.coffeeDir %>/*.<%= pkg.headSuffix %>.coffee'
		dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/'
		ext    : '.<%= pkg.headSuffix %>.js'

	buildCoffeeTail = 
		expand : yes
		flatten: yes
		src    : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.coffeeDir %>/*.<%= pkg.tailSuffix %>.coffee'
		dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/'
		ext    : '.<%= pkg.tailSuffix %>.js'

	buildJs =
		expand : yes
		flatten: yes
		src    : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.jsDir %>/*.js'
		dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/'

	buildCss =
		expand : yes
		flatten: yes
		src    : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.cssDir %>/*.css'
		dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>/'

	buildFonts =
		expand : yes
		flatten: yes
		src    : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.fontsDir %>/*'
		dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.fontsDir %>/'

	buildImages =
		expand : yes
		flatten: yes
		src    : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.imagesDir %>/*'
		dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.imagesDir %>/'

	buildTemplates =
		expand : yes
		cwd    : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.templatesDir %>/'
		src    : '**/*.html'
		dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.templatesDir %>/'

	buildScss =
		expand : yes
		flatten: yes
		src    : [ '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.scssDir %>/**/*.scss', '!**/_*.scss', '!**/*.<%= pkg.headSuffix %>.scss', '!**/*.body.scss' ]
		dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>/'
		ext    : '.css'

	buildScssHead =
		expand : yes
		flatten: yes
		src    : [ '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.scssDir %>/**/*.<%= pkg.headSuffix %>.scss', '!**/_*.scss' ]
		dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>/'
		ext    : '.<%= pkg.headSuffix %>.css'

	deployCss =
		expand : yes
		cwd   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>'
		src   : '*'
		dest   : '<%= pkg.deployCssDir %>'

	deployJs =
		expand: yes
		cwd   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>'
		src   : '*'
		dest  : '<%= pkg.deployJsDir %>'

	deployImages =
		expand: yes
		cwd   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.imagesDir %>'
		src   : '*'
		dest  : '<%= pkg.deployImagesDir %>'

	deployFonts =
		expand: yes
		cwd   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.fontsDir %>'
		src   : '*'
		dest  : '<%= pkg.deployFontsDir %>'

	deployHtmlTarget =
		expand : yes
		flatten: yes
		src   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.htmlTarget %>'
		dest  : '<%= pkg.deployHtmlTargetDir %>'

	builtTemplatesJs = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/9991_templates.<%= pkg.tailSuffix %>.js'

	builtJsHead    = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/*.<%= pkg.headSuffix %>.js'
	builtJsHeadMD5 = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/*.<%= pkg.headSuffix %>-*.js'
	builtJsTail    = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/*.<%= pkg.tailSuffix %>.js'
	builtJsTailMD5 = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/*.<%= pkg.tailSuffix %>-*.js'

	uglyJsHead    = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/<%= pkg.headSuffix %>.js'
	uglyJsHeadMD5 = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/<%= pkg.headSuffix %>-*.js'
	uglyJsTail    = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/<%= pkg.tailSuffix %>.js'
	uglyJsTailMD5 = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/<%= pkg.tailSuffix %>-*.js'

	prettyJsHead    = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/pretty_head.js'
	prettyJsHeadMD5 = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/pretty_head-*.js'
	prettyJsTail    = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/pretty_tail.js'
	prettyJsTailMD5 = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/pretty_tail-*.js'

	allPrettyJs    = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/pretty_all.js'
	allPrettyJsMD5 = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/pretty_all-*.js'
	allJs          = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/all.js'
	allJsMD5       = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/all-*.js'

	builtCssHead    = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>/*.<%= pkg.headSuffix %>.css'
	builtCssHeadMD5 = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>/*.<%= pkg.headSuffix %>-*.css'

	allCss      = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>/all.css'
	allCssMD5   = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>/all-*.css'
	allCssIE    = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>/all_ie.css'
	allCssIEMD5 = '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>/all_ie-*.css'

	md5Js =
		expand : yes
		flatten: yes
		dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>/'
		src    : [
			builtJsHead,
			builtJsTail,
			uglyJsHead,
			uglyJsTail,
			prettyJsHead,
			prettyJsTail,
			allPrettyJs,
			allJs
		]

	md5Css =
		expand : yes
		flatten: yes
		dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>/'
		src    : [
			builtCssHead,
			allCss,
			allCssIE
		]

	preprocessContext = flatExtend {}, packageJson
	preprocessContext = flatExtend preprocessContext, packageJson.applicationConfig[ packageJson.environment ], 'applicationConfig'

	gruntConfig =
		pkg: packageJson

		clean: 
			all       : [ '<%= pkg.buildDir %>/', '<%= pkg.deployJsDir %>', '<%= pkg.deployCssDir %>', '<%= pkg.deployImagesDir %>', '<%= pkg.deployFontsDir %>', '<%= pkg.deployHtmlTargetDir %>' ]
			coffee    : [ '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.coffeeDir %>', '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.jsDir %>', '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.jsDir %>', '<%= pkg.deployHtmlTargetDir %>', '<%= pkg.deployJsDir %>' ]
			scss      : [ '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.scssDir %>'  , '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>', '<%= pkg.deployHtmlTargetDir %>', '<%= pkg.deployCssDir %>' ]

		preprocess:
			options      : context: preprocessContext
			htmlTarget   : files: [ prepHtmlTarget ]
			prepCoffee   : files: [ prepCoffee ]
			prepScss     : files: [ prepScss ]
			prepJs       : files: [ prepJs ]
			prepCss      : files: [ prepCss ]
			prepTemplates: files: [ prepDirectiveTemplates, prepViewTemplates ]

		modernizr:
			outputFile: '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.jsDir %>/modernizr.<%= pkg.headSuffix %>.js'
			uglify    : yes
			parseFiles: no
			extra     :
				shiv      : yes
				printshiv : no
				load      : no
				mq        : no
				cssclasses: yes
			extensibility:
				addtest     : no
				prefixed    : no
				teststyles  : yes
				testprops   : yes
				testallprops: yes
				hasevents   : no
				prefixes    : yes
				domprefixes : yes
			tests: [
				"backgroundsize"
				"flexbox"
				"rgba"
				"cssanimations"
				"cssgradients"
				"csstransitions"
				"input"
				"inputtypes"
				"css_backgroundsizecover"
				"css_boxsizing"
			]

		copy: 
			prepFonts     : files: [ prepFonts ]
			prepImages    : files: [ prepImages ]
			buildJs       : files: [ buildJs ]
			buildCss      : files: [ buildCss ]
			buildFonts    : files: [ buildFonts ]
			buildImages   : files: [ buildImages ]
			buildTemplates: files: [ buildTemplates ]

			deploy: files: [
				deployJs
				deployCss
				deployImages
				deployFonts
				deployHtmlTarget
			]

		coffee:
			head: buildCoffeeHead
			tail: buildCoffeeTail

		ngtemplates:
			ngApp:
				cwd    : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.templatesDir %>'
				src    : '**/*.html'
				# src    : '**/*.<%= pkg.cacheSuffix %>.html'
				dest   : builtTemplatesJs

				options:
					module: packageJson.ngApp
					url: ( url ) ->
						grunt.config.process "#{
							packageJson.applicationConfig[ packageJson.environment ].defaultScheme
						}#{
							packageJson.applicationConfig[ packageJson.environment ].staticFileDomain
						}/#{
							packageJson.applicationConfig[ packageJson.environment ].staticFileDirectory
						}/#{
							packageJson.templatesDir
						}/#{
							url
						}#{
							packageJson.applicationConfig[ packageJson.environment ].staticFileSuffix
						}"
					htmlmin:
						collapseBooleanAttributes: no
						collapseWhitespace       : yes
						removeAttributeQuotes    : yes
						removeComments           : yes
						removeEmptyAttributes    : yes
						removeRedundantAttributes: yes

		sass:
			options:
				compass : yes
				loadPath: [
					'<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/**/<%= pkg.scssDir %>'
					'<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.scssDir %>/<%= pkg.taxonomyDir %>/<%= pkg.scssDir %>'
				]
				style   : 'condensed'
				require : 'animation'
			dist: files: [ buildScssHead, buildScss ]

		concat:
			prettyHead:
				options: separator: ';'
				src    : builtJsHead
				dest   : prettyJsHead
			prettyTail:
				options: separator: ';'
				src    : builtJsTail
				dest   : prettyJsTail
			allPrettyJs:
				options: separator: ';'
				src    : [ prettyJsHead, prettyJsTail ]
				dest   : allPrettyJs
			allCss:
				src: [ builtCssHead ]
				dest: allCss

		uglify:
			options:
				report: packageJson.report
			headJs:
				src : builtJsHead
				dest: uglyJsHead
			tailJs:
				src : builtJsTail
				dest: uglyJsTail
			allJs:
				src: [ builtJsHead, builtJsTail ]
				dest: allJs

		cssmin:
			options:
				report: packageJson.report
			allCss:
				src : [ builtCssHead ]
				dest: allCss

		bless:
			options:
				cleanup: yes
			files:
				expand: yes
				cwd : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>'
				src : 'all.css'
				dest: '<%= pkg.buildDir %>/<%= pkg.builtDir %>/<%= pkg.cssDir %>'
				ext : '_ie.css'

		md5:
			js     : md5Js
			css    : md5Css
			options:
				keepBasename : yes
				keepExtension: yes

		htmlbuild:
			development:
				src    : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.htmlTarget %>'
				dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/'
				options:
					prefix : '/<%= pkg.staticFileDirectory %>/'
					scripts:
						head: [ builtJsHeadMD5 ]
						tail: [ builtJsTailMD5 ]
					styles:
						head  : [ builtCssHeadMD5 ]
						headIE: [ allCssIEMD5 ]

			production:
				src    : '<%= pkg.buildDir %>/<%= pkg.almostBuiltDir %>/<%= pkg.htmlTarget %>'
				dest   : '<%= pkg.buildDir %>/<%= pkg.builtDir %>/'
				options:
					prefix : '/<%= pkg.staticFileDirectory %>/'
					scripts:
						head: [ allJsMD5 ]
						tail: []
					styles:
						head  : [ allCssMD5 ]
						headIE: [ allCssIEMD5 ]

		watch:
			options:
				livereload: yes # packageJson.liveReloadPort
				verbose   : yes
			gruntfile:
				files: [ 'Gruntfile.coffee', 'package.json' ]
				tasks: [ '<%= pkg.environment %>' ]
			scss:
				files: [ '**/<%= pkg.scssDir %>/**/*.scss', '**/<%= pkg.cssDir %>/**/*.css', '!<%= pkg.buildDir %>/**/*' ]
				tasks: [ 'scss_<%= pkg.applicationConfig[ pkg.environment ].type %>' ]
			coffee:
				files: [ '**/<%= pkg.coffeeDir %>/**/*.coffee', '**/<%= pkg.templatesDir %>/**/*.html', '!<%= pkg.buildDir %>/**/*' ]
				tasks: [ 'coffee_<%= pkg.applicationConfig[ pkg.environment ].type %>' ]
			statics:
				files: [ '**/<%= pkg.jsDir %>/**/*.js', '**/<%= pkg.cssDir %>/**/*.css', '**/<%= pkg.fontsDir %>/**/*', '**/<%= pkg.imagesDir %>/**/*', '!node_modules/**/*', '!<%= pkg.buildDir %>/**/*' ]
				tasks: [ 'copy:prepFonts', 'copy:prepImages', 'copy:buildJs', 'copy:buildCss', 'copy:buildFonts', 'copy:buildImages', 'copy:buildTemplates', 'ngtemplates', 'concat', 'htmlbuild:<%= pkg.applicationConfig[ pkg.environment ].type %>', 'copy:deploy' ]
			htmlTarget:
				files: [ '<%= pkg.htmlTarget %>' ]
				tasks: [ 'preprocess', 'htmlbuild:<%= pkg.applicationConfig[ pkg.environment ].type %>', 'copy:deploy' ]

	grunt.initConfig gruntConfig

	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-html-build'
	grunt.loadNpmTasks 'grunt-preprocess'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-cssmin'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-angular-templates'
	grunt.loadNpmTasks 'grunt-modernizr'
	grunt.loadNpmTasks 'grunt-bless'
	grunt.loadNpmTasks 'grunt-md5'

	tasksByType = 
		development: [ 
			'clean:all'
			'preprocess'
			'modernizr'
			'copy:prepFonts', 'copy:prepImages', 'copy:buildJs', 'copy:buildCss', 'copy:buildFonts', 'copy:buildImages', 'copy:buildTemplates'
			'coffee'
			'ngtemplates'
			# 'uglify'
			'sass'
			'concat'
			'cssmin'
			'bless'
			'preprocess:htmlTarget'
			'md5'
			'htmlbuild:development'
			'copy:deploy'
		]
		production: [ 
			'clean:all'
			'preprocess'
			'modernizr'
			'copy:prepFonts', 'copy:prepImages', 'copy:buildJs', 'copy:buildCss', 'copy:buildFonts', 'copy:buildImages', 'copy:buildTemplates'
			'coffee'
			'ngtemplates'
			'uglify'
			'sass'
			'concat'
			'cssmin'
			'bless'
			'preprocess:htmlTarget'
			'md5'
			'htmlbuild:production'
			'copy:deploy'
		]

	grunt.registerTask environment, tasksByType[ applicationConfig.type ] for environment, applicationConfig of packageJson.applicationConfig

	grunt.registerTask 'default', tasksByType[ packageJson.applicationConfig[ packageJson.environment ].type ]

	watchTasks =
		scss_development: [ 'clean:scss', 'preprocess:prepScss', 'preprocess:prepCss', 'copy:buildCss', 'sass', 'concat:allCss', 'cssmin', 'bless', 'md5', 'htmlbuild:development', 'copy:deploy' ]
		scss_production : [ 'clean:scss', 'preprocess:prepScss', 'preprocess:prepCss', 'copy:buildCss', 'sass', 'concat:allCss', 'cssmin', 'bless', 'md5', 'htmlbuild:production',  'copy:deploy' ]

		coffee_development: [ 'clean:coffee', 'preprocess:prepCoffee', 'preprocess:prepJs', 'preprocess:prepTemplates', 'modernizr', 'copy:buildJs', 'copy:buildTemplates', 'coffee', 'ngtemplates', 'concat:prettyHead', 'concat:prettyTail', 'concat:allPrettyJs',           'md5', 'htmlbuild:development', 'copy:deploy' ]
		coffee_production : [ 'clean:coffee', 'preprocess:prepCoffee', 'preprocess:prepJs', 'preprocess:prepTemplates', 'modernizr', 'copy:buildJs', 'copy:buildTemplates', 'coffee', 'ngtemplates', 'concat:prettyHead', 'concat:prettyTail', 'concat:allPrettyJs', 'uglify', 'md5', 'htmlbuild:production',  'copy:deploy' ]

	grunt.registerTask watchTasksName, tasks for watchTasksName, tasks of watchTasks

	grunt.log.writeln "Build environment: #{ packageJson.environment }, Build type: #{ packageJson.applicationConfig[ packageJson.environment ].type }"