# @author Gianluigi Mango
# Notifier
module.exports = class Notifier extends Error
	constructor: (@data, @res, @error) ->
		super @data, @res, @error

		unless @error then @emitMessage.call @ else (if typeof @error is 'boolean' then @throwError.call @ else @emitFalse.call @)

	throwError: ->
		@res.send error: @data, response: false

	emitMessage: ->
		@res.send data: @data, response: true

	emitFalse: ->
		@res.send data: @data, response: false