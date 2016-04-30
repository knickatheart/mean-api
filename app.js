/**
 *	@author knickatheart
 *	Example API bootstrap
 */
var express = require('express');
	db = require('./server/db/connection.js'),
	api = require('./server/api.handler.js'),
	bodyParser = require('body-parser'),
	app = express()

app.listen('3000', console.info('[Server] started on port 3000'))

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())

db.connect()

app.use('/api', function(req, res) {
	if (req && req.url !== '/') {
		api(req.url, res, req.body)
	} else {
		res.send({ error: 'No endpoint specified' })
	}
});

module.exports = app