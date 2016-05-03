(function() {
  var User;

  User = require('./../models/userModel');

  module.exports = function(action, path, res) {
    var addUser, deleteuser, getInfo;
    this.path = path;
    this.action = action;
    console.info('[Query]', action);
    getInfo = function() {
      return User.findOne({
        userid: this.path[0][1]
      }, function(err, body) {
        if (err) {
          return console.log(err);
        } else {
          if (body) {
            return res.send({
              data: body,
              response: true
            });
          } else {
            return res.send({
              data: 'Not found',
              response: false
            });
          }
        }
      });
    };
    addUser = function() {
      var user;
      user = new User({
        userid: this.path[0][1],
        password: this.path[1][1],
        active: 1
      });
      return user.save(function(err, body) {
        if (err) {
          return console.log(err);
        } else {
          if (body) {
            return res.send({
              data: body,
              response: true
            });
          } else {
            return res.send({
              response: false
            });
          }
        }
      });
    };
    deleteuser = function() {
      return User.remove({
        _id: this.path[0][1]
      }, function(err, body) {
        if (err) {
          return console.log(err);
        } else {
          if (body) {
            return res.send({
              data: 'Deleted successfully',
              response: true
            });
          } else {
            return res.send({
              data: 'Not found',
              response: false
            });
          }
        }
      });
    };
    switch (action) {
      case 'getInfo':
        return getInfo();
      case 'addUser':
        return addUser();
      case 'deleteUser':
        return deleteuser();
      default:
        return res.send({
          Error: 'No method found'
        });
    }
  };

}).call(this);
