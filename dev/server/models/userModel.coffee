# @author Gianluigi Mango
# User Model
mongoose = require 'mongoose'

module.exports = mongoose.model 'User',
	mongoose.Schema
		userid: String,
		images: Array,
		posts: Array,
		password: String,
		active: Number
	'citizens'