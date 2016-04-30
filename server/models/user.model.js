/**
 *	@author knickatheart
 *	User Model
 */
var mongoose = require('mongoose');

const User = mongoose.Schema({
	userid: String,
	password: String,
	active: Number
});

module.exports = mongoose.model('User', User, 'citizens');