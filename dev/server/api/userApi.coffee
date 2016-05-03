# @author Gianluigi Mango
User = require './../models/userModel'

# @this.path[0] = key, @this.path[1] = value
module.exports = (action, path, res) ->
	@path = path
	@action = action

	console.info '[Query]', action

	getInfo = ->
		User.findOne userid: @path[0][1], (err, body) ->
			if err
				console.log err
			else
				if body then res.send data: body, response: true else res.send data: 'Not found', response: false

	addUser = ->
		user = new User
			userid: @path[0][1],
			password: @path[1][1],
			active: 1

		user.save (err, body) ->
			if err 
				console.log err
			else 
				if body then res.send data: body, response: true else res.send response: false

	deleteuser = ->
		User.remove _id: @path[0][1], (err, body) ->
			if err
				console.log err
			else
				if body then res.send data: 'Deleted successfully', response: true else res.send data: 'Not found', response: false

	switch action
		when 'getInfo' then getInfo()
		when 'addUser' then addUser()
		when 'deleteUser' then deleteuser()
		else res.send Error: 'No method found'