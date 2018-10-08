###
Log messages into console
###
LEVELS= ['debug', 'log', 'info', 'warn', 'error', 'fatalError']
CONSOLE_COLORS=
	debug: ''
	log: ''
	info: "\x1b[36m"
	warn: "\x1b[33m"
	error: "\x1b[31m"
	fatalError: "\x1b[31m"

# print logs into console
printLog = (method)->
	color = CONSOLE_COLORS[method]
	mt = "\x1b[7m".concat color, method.toUpperCase(), "\t\x1b[0m", color
	()->
		args = Array.from arguments
		# GERROR
		for el, i in args
			if el.code
				args[i] = el.toString()
		# 
		args.unshift mt
		args[1] = args[1] + ">>\t"
		args.push "\x1b[0m"
		console.log.apply console, args

# add methods
for m in LEVELS
	exports[m]= printLog m