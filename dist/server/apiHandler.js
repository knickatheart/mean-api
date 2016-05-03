(function() {
  var PATH, fs;

  fs = require('fs');

  PATH = 'server/api/';

  module.exports = function(req, res, post) {
    var action, emitError, evaluated, execution, fragment, iterator, splitted;
    emitError = function() {
      res.send({
        error: 'No fragment or no parameters have been specified check your query',
        example: '/api/fragment/method?parameter=value'
      });
    };
    fragment = req.split('/');
    splitted = fragment[2] ? fragment[2].split('?') : emitError();
    action = splitted[0];
    execution = splitted[1];
    iterator = [];
    evaluated = [];
    if (!(fragment[2] || execution)) {
      emitError();
    }
    return fs.access(PATH + fragment[1] + 'Api.js', fs.F_OK, function(err) {
      var i, makeCall, splittedData;
      if (err) {
        emitError();
      }
      console.info('[Request]', fragment[1]);
      makeCall = require('./api/' + fragment[1] + 'Api');
      if (Object.keys(post).length) {
        evaluated = (function() {
          var results;
          results = [];
          for (i in post) {
            results.push([i, post[i]]);
          }
          return results;
        })();
      } else {
        splittedData = execution.split('&');
        evaluated = (function() {
          var results;
          results = [];
          for (i in splittedData) {
            results.push(splittedData[i].split('='));
          }
          return results;
        })();
      }
      return makeCall(action, evaluated, res);
    });
  };

}).call(this);
