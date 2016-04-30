/**
 *	@author knickatheart
 *	database connection
 */
var mongoose = require('mongoose');

const USER = 'example';
const PASS = 'example';

module.exports = {
	connect: function() {
		return mongoose.connect('mongodb://' + USER + ':' + PASS + '@example.com:example/example', function(err) {
			if (err) {
				console.log(err);
			} else {
				console.log('[MongoDB] Connected');
			}
		});
	},

	mongo: mongoose
}