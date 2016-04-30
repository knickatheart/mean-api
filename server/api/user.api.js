/**
 *	@author knickatheart
 *	API example
 */
const User = require('./../models/user.model.js')

/**
 *	@this.path[0] = key, @this.path[1] = value
 */
module.exports = function(action, path, res) {
	this.path = path;
	this.action = action;

	console.info('[Query]', action);

	switch (action) {
		case 'getInfo': 	getInfo(); 		break
		case 'addUser': 	addUser(); 		break
		case 'deleteUser': 	deleteUser(); 	break

		default: res.send({ Error: 'No method found' })
	}

	/**
	 *	Get info for citizen
	 *	@return Obj
	 */
	function getInfo() {
		User.findOne({ userid: this.path[1] }, function(err, body) {
			if (err) {
				console.log(err)
			} else {
				body ? res.send({ data: body, response: true }) : res.send({ data: 'Not found', response: false })
			}
		})
	}

	/**
	 *	Create new citizen
	 *	@return Obj
	 */
	function addUser() {
		var user = new User({
			userid: this.path[0][1],
			password: this.path[1][1],
			active: 1
		})

		user.save(function(err, body) {
			if (err) {
				console.log(err)
			} else {
				body ? res.send({ data: body, response: true }) : res.send({ response: false }) 
			}
		})
	}

	/**
	 *	Delete citizen
	 *	@return Obj
	 */
	function deleteUser() {
		User.remove({ _id: this.path[1] }, function(err, body) {
			if (err) {
				res.send({ data: err.message, response: false })
			} else {
				body ? res.send({ data: 'Deleted successfully', response: true }) : res.send({ data: 'Not found', response: false })
			}
		})
	}
}