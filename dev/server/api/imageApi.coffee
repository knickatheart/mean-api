# @author Gianluigi Mango
# Image API
ImageHandler = require './handler/imageHandler'

module.exports = class ImageApi 
	constructor: (@action, @path, @req, @res) ->
		@imageHandler = new ImageHandler @req

		console.info '[Query]', action

		switch @action
			when 'getProfileImage' then @imageHandler.getProfileImage @path, @res

			else res.send Error: 'No method found'