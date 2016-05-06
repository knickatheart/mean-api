# @author Gianluigi Mango
# User API
UserHandler = require './handler/userHandler'

module.exports = class UserApi 
	constructor: (@action, @path, @req, @res) ->
		@userHandler = new UserHandler @req

		console.info '[Query]', action

		switch @action
			when 'getInfo' then @userHandler.getInfo @path, @res
			when 'addUser' then @userHandler.addUser @path, @res
			when 'deleteUser' then @userHandler.deleteUser @path, @res
			when 'login' then @userHandler.loginUser @path, @res
			when 'checkUser' then @userHandler

			else res.send Error: 'No method found'