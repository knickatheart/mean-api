# @author Gianluigi Mango
# Database Connection
mongoose = require 'mongoose'

USER = 'example'
PASS = 'example'

module.exports =
	connect: ->
		mongoose.connect 'mongodb://' + USER + ':' + PASS + '@example.example.example:example/example', (err) ->
			return console.info if err then err else '[MongoDB] Connected' 

	mongo: mongoose