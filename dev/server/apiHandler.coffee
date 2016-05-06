# @author Gianluigi Mango
# Handle API requests
fs = require 'fs'
Notify = require './api/utils/Notifier'

# Automatically detect GET or POST requests
module.exports = (req, res, post) ->
	errorMessage = message: 'No fragment or no parameters have been specified check your query', example: '/api/fragment/method?parameter=value'
	url = req.url
	fragment = url.split '/'
	splitted = if fragment[2] then fragment[2].split('?') else new Notify errorMessage, res, true
	action = splitted[0]
	execution = splitted[1]
	iterator = []
	evaluated = []

	new Notify errorMessage, res, true unless fragment[2] or execution

	fs.access __dirname + '/api/' + fragment[1] + 'Api.js', fs.F_OK, (err) ->
		new Notify err, res, true if err

		console.info '[Request]', fragment[1]

		makeCall = require './api/' + fragment[1] + 'Api'

		# [POST] Transform Object to Multi Array 
		# [GET] Transform comma separated array to Multi Array
		if Object.keys(post).length
			evaluated = ([i, post[i]] for i of post)
		else	
			splittedData = execution.split('&')
			evaluated = (splittedData[i].split('=') for i of splittedData)

		makeCall action, evaluated, req, res
