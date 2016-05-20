# @author Gianluigi Mango
# Post Model
mongoose = require 'mongoose'

module.exports = mongoose.model 'Post',
	mongoose.Schema
		parent: String,
		data: String,
		active: Number,
		reactions: Array,
		comments: Array,
		createdAt: String
	'posts'