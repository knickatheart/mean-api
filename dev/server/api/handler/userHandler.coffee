# @author Gianluigi Mango
# Handle User API
UserModel = require './../model/userModel'
PostModel = require './../model/postModel'
PostHandler = require './postHandler'
Notify = require './../utils/Notifier'
bcrypt = require 'bcrypt-nodejs'

module.exports = class userHandler
	# Check if there is an active session
	constructor: (@req) ->
		@userModel = new UserModel
		@postModel = new PostModel
		@postHandler = new PostHandler

	checkSession: (req, res) ->
		if not req.session.user then new Notify 'Not in session', res, 1 else new Notify req.session.user, res, false

	getInfo: (path, res) ->
		@userModel.findUser path[0][1], (exists) =>
			if exists
				@postModel.getAll exists[0]._id, (err, body) ->
					if not err
						exists.push body
						new Notify exists, res, false
					else 
						new Notify err, res, true
			else
				new Notify 'User does not exist', res, true

	addUser: (path, res) ->
		@userModel.findUser path[0][1], (exists) =>
			if exists
				new Notify 'User already exists', res, 1
			else
				bcrypt.genSalt 10, (err, salt) =>
					if err
						throw err
					else
						bcrypt.hash path[1][1], salt, (err) =>
							if err then new Notify err, res, true
						, (err, hash) =>
							path[1][1] = hash

							@userModel.addUser path, (err, body) =>
								unless err then new Notify body, res, false else new Notify err, res, true

	deleteUser: (path, res) ->
		@userModel.findUser path[0][1], (exists) =>
			if not exists
				new Notify 'User does not exist', res, 1
			else
				@userModel.deleteUser exists[0]._id, (err, body) ->
					unless err then new Notify 'Deleted successfully', res, false else console.log new Notify err, res, true

	loginUser: (path, res) ->
		@userModel.findUser path[0][1], (exists) =>
			if exists
				if bcrypt.compareSync path[1][1], exists[0].password
					@postHandler.getAll exists[0]._id, (err, body) =>
						if not err
							exists.push body
							console.log body
							@setSession exists, res
						else 
							new Notify err, res, true
				else
					new Notify 'Wrong password', res, true
			else
				new Notify 'User not found', res, true

	logout: (path, res) ->
		@req.session.reset()
		new Notify 'User logged out', res, false

	setSession: (user, res) ->
		@req.session.user = user[0]
		res.locals.user = user[0]

		new Notify user, res, false