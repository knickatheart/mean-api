# @author Gianluigi Mango
# Query Image Collection
Image = require './../../models/imageModel'

module.exports = class ImageModel

	# Find one image in collection
	# @params id[String], cb[Function]
	# @return callback
	getProfileImage: (id, cb) ->
		Image.find profileId: id, (err, body) ->
			cb err, body