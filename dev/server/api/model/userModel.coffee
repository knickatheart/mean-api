# @author Gianluigi Mango
# Query User Collection
User = require './../../models/userModel'
Image = require './../../models/imageModel'
Post = require './../../models/postModel'

module.exports = class UserModel

	# Find one user in collection
	# @params user[String], cb[Function]
	# @return callback
	findUser: (user, cb) ->
		User.find userid: user
		.populate path: 'images', model: Image
		.populate path: 'posts', model: Post
		.exec (err, body) ->
			unless err then (if body.length then cb body else cb false) else console.log err

	# Add one user to the collection
	# @params data[Array], cb[Function]
	# @return callback
	addUser: (data, cb) ->
		user = new User
			userid: data[0][1],
			password: data[1][1],
			active: 1

		user.save (err, body) ->
			cb err, body

	# Delete one user in collection
	# @params id[Number], cb[Function]
	# @return callback
	deleteUser: (id, cb) ->
		User.remove _id: id, (err, body) ->
			cb err, body

	# Find one user in collection by ID
	# @params id[String], cb[Function]
	# @return callback
	findByUserId: (id, cb) ->
		User.findById id
		.populate path: 'images', model: Image
		.exec (err, body) ->
			cb err, body