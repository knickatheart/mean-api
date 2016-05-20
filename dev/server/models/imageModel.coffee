# @author Gianluigi Mango
# Image Model
mongoose = require 'mongoose'

module.exports = mongoose.model 'Image',
	mongoose.Schema
		parent: String,
		url: String,
		active: Number
	'images'