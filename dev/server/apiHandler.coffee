# @author Gianluigi Mango
fs = require 'fs'
PATH = 'server/api/'

# Automatically detect GET or POST requests
module.exports = (req, res, post) ->
	emitError = ->
		res.send error: 'No fragment or no parameters have been specified check your query', example: '/api/fragment/method?parameter=value'
		return

	fragment = req.split '/'
	splitted = if fragment[2] then fragment[2].split('?') else emitError()
	action = splitted[0]
	execution = splitted[1]
	iterator = []
	evaluated = []

	emitError() unless fragment[2] or execution

	fs.access PATH + fragment[1] + 'Api.js', fs.F_OK, (err) ->
		emitError() if err

		console.info '[Request]', fragment[1]

		makeCall = require './api/' + fragment[1] + 'Api'

		# [POST] Transform Object to Multi Array 
		# [GET] Transform comma separated array to Multi Array
		if Object.keys(post).length
			evaluated = ([i, post[i]] for i of post)
		else	
			splittedData = execution.split('&')
			evaluated = (splittedData[i].split('=') for i of splittedData)

		makeCall action, evaluated, res
