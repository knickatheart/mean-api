# @author Gianluigi Mango
# Post API
PostHandler = require './handler/postHandler'

module.exports = class UserApi 
	constructor: (@action, @path, @req, @res) ->
		@postHandler = new PostHandler @req

		console.info '[Query]', action

		switch @action
			when 'getAll' then @postHandler.getAll @path, @res
			when 'savePost' then @postHandler.savePost @path, @res

			else res.send Error: 'No method found'