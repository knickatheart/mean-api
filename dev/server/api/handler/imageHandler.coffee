# @author Gianluigi Mango
# Handle Image API
ImageModel = require './../model/imageModel'
Notify = require './../utils/Notifier'

module.exports = class imageHandler
	# Check if there is an active session
	constructor: (@req) ->
		@imageModel = new ImageModel

	getProfileImage: (path, res) ->
		@imageModel.getProfileImage path[0][1], (err, body) ->
			unless err then new Notify body, res, false else new Notify err, res, true