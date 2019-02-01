###
Log messages into console
###
LEVELS= ['debug', 'log', 'info', 'warn', 'error', 'fatalError']
CONSOLE_COLORS=
	debug: ''
	log: ''
	info: "\x1b[36m"
	warn: "\x1b[93m"
	error: "\x1b[31m"
	fatalError: "\x1b[31m"

# print logs into console
printLog = (method)->
	color = CONSOLE_COLORS[method]
	mt = "\x1b[7m".concat color, ' -', method.toUpperCase(), "- \t\x1b[0m", color
	()->
		txt = [mt, arguments[0], ">>\t"]
		len = arguments.length
		i= 1
		while i < len
			ele = arguments[i++]
			if typeof ele is 'object'
				# NULL
				if ele is null
					txt.push ' NULL'
				# ERROR
				else if ele instanceof Error
					if ele.extra # Gfw error
						txt.push " #{ele.toString()}"
					else
						txt.push " Error: #{ele.message}\n#{ele.stack}"
				# Obj
				else
					txt.push ' ', ele.constructor?.name || '', '{'
					for k,v of Object.getOwnPropertyDescriptors ele
						txt.push "\n\t", k, ': '
						if 'value' of v
							vv = v.value
							if typeof vv is 'object'
								txt.push if vv is null then 'NULL' else '{...}'
							else if vv is undefined
								txt.push 'UNDEFINED'
							else if typeof vv is 'function'
								txt.push v.name || 'Anonymous', '(){...}'
							else
								txt.push v.toString()
						else if 'get' of v
							txt.push if 'set' of v then 'GETTER_SETTER' else 'GETTER'
						else if 'set' of v
							txt.push 'SETTER'
						else
							txt.push '??'
					txt.push "\n}"
			else if ele is undefined
				txt.push ' UNDEFINED'
			else
				txt.push ' ', ele.toString()
		# print
		txt.push '\x1b[0m'
		console.log txt.join ''

# add methods
for m in LEVELS
	exports[m]= printLog m