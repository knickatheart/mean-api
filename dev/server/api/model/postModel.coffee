# @author Gianluigi Mango
# Query Posts Collection
Post = require './../../models/postModel'
Reaction = require './../../models/reactionModel'
Comment = require './../../models/commentModel'

module.exports = class PostModel

	# Find all posts in collection with relative reactions and comments
	# @params id[String], cb[Function]
	# @return callback
	getAll: (id, cb) ->
		Post.find parent: id
		.populate path: 'reactions', model: Reaction
		.populate path: 'comments', model: Comment
		.exec (err, body) ->
			cb err, body

	# Save one post in collection
	# @params data[Array], cb[Function]
	# @return callback
	savePost: (data, cb) ->
		post = new Post
			parent: data[0][1],
			data: data[1][1],
			active: 1,
			reactions: [],
			comments: [],
			createdAt: new Date()

		post.save (err, body) ->
			cb(err, body)