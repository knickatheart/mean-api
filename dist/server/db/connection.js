(function() {
  var PASS, USER, mongoose;

  mongoose = require('mongoose');

  USER = 'space_name';

  PASS = 'space_unique_password';

  module.exports = {
    connect: function() {
      return mongoose.connect('mongodb://' + USER + ':' + PASS + '@ds021751.mlab.com:21751/space', function(err) {
        return console.info(err ? err : '[MongoDB] Connected');
      });
    },
    mongo: mongoose
  };

}).call(this);
