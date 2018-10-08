###
void logger
###
LEVELS= ['debug', 'log', 'info', 'warn', 'error', 'fatalError']
VOID = ->

for l in LEVELS
	exports[l] = VOID
