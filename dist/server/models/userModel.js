(function() {
  var mongoose;

  mongoose = require('mongoose');

  module.exports = mongoose.model('User', mongoose.Schema({
    userid: String,
    password: String,
    active: Number
  }), 'citizens');

}).call(this);
