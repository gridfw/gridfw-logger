###*
 * Show monitoring for GridFW apps
###
LoggerFactory = require './logger-factory'
module.exports = (_options)->
	# check gridfw min version
	name: 'GridFW-logger'
	GridFWVersion: '0.x.x'
	# init
	init: (app)->
		# load logger
		LoggerFactory app, options
		LoggerFactory app.Context, options
		return
	# reload settings
	reload: (app, options)->
		app.logLevel = options?.level || 'debug'
		return
		
