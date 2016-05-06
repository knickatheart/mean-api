# @author Gianluigi Mango
# Handle User API
UserModel = require './../model/userModel'
Notify = require './../utils/Notifier'
bcrypt = require 'bcrypt-nodejs'

module.exports = class userHandler
	# Check if there is an active session
	constructor: (@req) ->
		@userModel = new UserModel

		if @req.session?.user?.active then new Notify @req.session.user.userid, res, false else new Notify 'User not in session', res, 1

	getInfo: (path, res, notify) ->
		@userModel.findUser path[0][1], (exists) ->
			if exists? then new Notify exists, res, false else new Notify 'User does not exist', res, true

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
					@setSession exists, res
				else
					new Notify 'Wrong password', res, true
			else
				new Notify 'User not found', res, true

	setSession: (user, res) ->
		@req.session.user = user[0]
		res.locals.user = user[0]

		new Notify user[0].userid + ' logged in', res, false