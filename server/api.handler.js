/**
 *	@author knickatheart
 */

var fs = require('fs')
const PATH = 'server/api/'

/**
 *	Automatically detect GET or POST requests
 */
module.exports = function(req, res, post) {
	var fragment = req.split('/'),
		splitted = fragment[2] ? fragment[2].split('?') : emitError(),
		action = splitted[0],
		execution = splitted[1],
		iterator = [], evaluated = [], makeCall	

	if (!fragment[2] || !execution) emitError()

	function emitError() {
		res.send({ error: 'No fragment or no parameters have been specified check your query', example: '/api/fragment/method?parameter=value' })
		return
	}

	fs.access(PATH + fragment[1] + '.api.js', fs.F_OK, function(err) {
		if (err) {
			console.log(err)
		} else {
			console.info('[Request]', fragment[1])

			makeCall = require('./api/' + fragment[1] + '.api.js')

			/**
			 * 	[POST] Transform Object to Multi Array 
			 *	[GET] Transform comma separated array to Multi Array
			 */
			if (!Object.keys(post).length) {
				var split = execution.split('&')

				for (i in split) {
					evaluated.push(split[i].split('='))
				}
			} else {
				for (i in post) {
					evaluated.push([i, post[i]])
				}
			}
	
			makeCall(action, evaluated, res)
		}
	})
}