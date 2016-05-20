# @author Gianluigi Mango
# Comment Model
mongoose = require 'mongoose'

module.exports = mongoose.model 'Comment',
	mongoose.Schema
		parent: String,
		data: String,
		active: Number,
		createdBy: String,
		createdAt: String
	'comments'