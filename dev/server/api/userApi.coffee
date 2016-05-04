# @author Gianluigi Mango
User = require './../models/userModel'

# @this.path[0] = key, @this.path[1] = value
module.exports = (action, path, res) ->
	console.info '[Query]', action

	getInfo = ->
		findUser path[0][1], (exists) ->
			if exists then res.send data: exists, response: true else res.send data: 'User does not exist', response: false

	addUser = ->
		user = new User
			userid: path[0][1],
			password: path[1][1],
			active: 1

		findUser user.userid, (exists) ->
			if exists
				res.send data: 'User already exists', response: false
			else
				user.save (err, body) ->
					unless err then (if body then res.send data: body, response: true else res.send response: false) else console.log err

	deleteUser = ->
		User.remove _id: path[0][1], (err, body) ->
			if err
				console.log err
			else
				if body then res.send data: 'Deleted successfully', response: true else res.send data: 'Not found', response: false

	# @private function @return cb
	findUser = (user, cb) ->
		User.find userid: user, (err, docs) ->
			unless err then (if docs.length then cb docs else cb false) else console.log err	

	switch action
		when 'getInfo' then getInfo()
		when 'addUser' then addUser()
		when 'deleteUser' then deleteUser()
		else res.send Error: 'No method found'