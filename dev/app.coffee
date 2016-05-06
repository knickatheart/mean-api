# @author Gianluigi Mango
# Bootstrap App
express = require 'express'
db = require './server/db/connection.js'
api = require './server/apiHandler.js'
bodyParser = require 'body-parser'
session = require 'client-sessions'
app = express()

app.listen '3000', console.info '[Listening] 3000'

app.use bodyParser.urlencoded extended: true
app.use bodyParser.json()

app.use session
	cookieName: 'session',
	secret: 'eg[isfd-8yF9-7w2315df{}+Ijsli;;to8',
	duration: 30 * 60 * 1000,
	activeDuration: 5 * 60 * 1000,
	httpOnly: true,
  	secure: true,
  	ephemeral: true

db.connect()

app.use '/api', (req, res) ->
	if req and req.url != '/' then api req, res, req.body else res.send error: 'No endpoint specified'

module.exports = app