# @author Gianluigi Mango
# Handle User API
PostModel = require './../model/postModel'
UserModel = require './../model/userModel'
Notify = require './../utils/Notifier'
_ = require 'lodash'

extend = exports.extend = (object, properties) ->
  	for key, val of properties
    	object[key] = val
  	object

module.exports = class userHandler
	# Check if there is an active session
	constructor: (@req) ->
		@postModel = new PostModel
		@userModel = new UserModel

	getAll: (path, cb) ->
		console.log(path)
		@postModel.getAll path, (err, body) =>
			if not err
				comments = body[1]['comments']

				getCreators = () =>
					array = []
					for i of comments
						@userModel.findByUserId comments[i]['createdBy'], (err, res) =>
							array.push res

					_.delay ( => cb err, {data: body, creators: array} ), 1000 	

				creators = getCreators.call @

	savePost: (path, res) ->
		@postModel.savePost path, (err, body) ->
			@handleCb err, body

	handleCb: (err, body) ->
		unless err then new Notify body, res, false else new Notify err, res, true