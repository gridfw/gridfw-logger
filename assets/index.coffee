###*
 * Show monitoring for GridFW apps
###
# void
LoggerVoid = require './logger-void'
# Log to console (dev mode)
LoggerConsole = require './logger-console'

LEVELS= ['debug', 'log', 'info', 'warn', 'error', 'fatalError']

VOID = ->

module.exports= (app, {level, mode})->
	# set log level
	level ?= 'debug'
	mode ?= 'dev'

	# enable console logger
	logger = LoggerConsole
	#TODO add file based console
	levelIndex = LEVELS.indexOf level || 'debug'
	throw new Error "Unknown logger level: #{level}" if levelIndex is -1
	i= 0
	while i < levelIndex
		Object.defineProperty app, LEVELS[i],
			value: VOID
			configurable: true
			writable: true
		++i
	len = LEVELS.length
	while i < len
		k = LEVELS[i]
		Object.defineProperty app, k,
			value: logger[k]
			configurable: true
			writable: true
		++i
	return