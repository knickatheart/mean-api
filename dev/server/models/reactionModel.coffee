# @author Gianluigi Mango
# Reaction Model
mongoose = require 'mongoose'

module.exports = mongoose.model 'Reaction',
	mongoose.Schema
		parent: String,
		type: String,
		active: Number,
		createdBy: String,
		createdAt: String
	'reactions'