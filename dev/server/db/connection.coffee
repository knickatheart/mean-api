# @author Gianluigi Mango
# database connection
mongoose = require 'mongoose'

USER = 'space_name'
PASS = 'space_unique_password'

module.exports =
	connect: ->
		mongoose.connect 'mongodb://' + USER + ':' + PASS + '@ds021751.mlab.com:21751/space', (err) ->
			return console.info if err then err else '[MongoDB] Connected' 

	mongo: mongoose