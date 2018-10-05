### logger ###
LEVELS= ['debug', 'log', 'info', 'warn', 'error', 'fatalError']
_VOID = ->


module.exports = (obj, options)->
	# set log level
	level = options?.level || 'debug'
	Object.defineProperties obj,
		_logLevel:
			value: level
			configurable: true
			writable: true
		logLevel:
			set: _setLogLevel
			get: -> @_logLevel
			configurable: true # enable to change this default logger
	# set level
	obj.logLevel = level
	return

_setLogLevel = (level)->
	#TODO use console.log in dev mode
	#TODO use performante logger in 
	throw new Error "Usupported level: #{level}, supported are: #{LEVELS}" unless level in LEVELS
	@_logLevel = level
	for logMethod in LEVELS
		_createConsoleLogMethod level, this, logMethod
	return


CONSOLE_COLORS=
	debug: ''
	log: ''
	info: "\x1b[36m"
	warn: "\x1b[33m"
	error: "\x1b[31m"
	fatalError: "\x1b[31m"

_createConsoleLogMethod = (level, obj, method)->
	color = CONSOLE_COLORS[method]
	mt = "\x1b[7m".concat color, method.toUpperCase(), "\t\x1b[0m", color
	# fatalError: add blink
	if method is 'fatalError'
		mt = "\x1b[5m" + mt
	# Add
	Object.defineProperty obj, method,
			value: if LEVELS.indexOf(method) < level then _VOID else ->
				# change GError Presentation
				args = Array.from arguments
				for el, i in args
					if el.code # GERROR
						args[i] = el.toString()
				# 
				args.unshift mt
				args[1] = args[1] + ">>\t"
				args.push "\x1b[0m"
				console.log.apply console, args
			configurable: true
	return