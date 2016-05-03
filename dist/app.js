(function() {
  var api, app, bodyParser, db, express;

  express = require('express');

  db = require('./server/db/connection.js');

  api = require('./server/apiHandler.js');

  bodyParser = require('body-parser');

  app = express();

  app.listen('3000', console.info('[Listening] 3000'));

  app.use(bodyParser.urlencoded({
    extended: true
  }));

  app.use(bodyParser.json());

  db.connect();

  app.use('/api', function(req, res) {
    if (req && req.url !== '/') {
      return api(req.url, res, req.body);
    } else {
      return res.send({
        error: 'No endpoint specified'
      });
    }
  });

  module.exports = app;

}).call(this);
