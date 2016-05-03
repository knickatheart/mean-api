# @author Gianluigi Mango
express = require 'express'
db = require './server/db/connection.js'
api = require './server/apiHandler.js'
bodyParser = require 'body-parser'
app = express()

app.listen '3000', console.info '[Listening] 3000'

app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()

db.connect()

app.use '/api', (req, res) ->
	if req and req.url != '/' then api req.url, res, req.body else res.send error: 'No endpoint specified'

module.exports = app