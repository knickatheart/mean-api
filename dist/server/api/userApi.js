(function() {
  var User;

  User = require('./../models/userModel');

  module.exports = function(action, path, res) {
    var addUser, deleteUser, findUser, getInfo;
    console.info('[Query]', action);
    getInfo = function() {
      return findUser(path[0][1], function(exists) {
        if (exists) {
          return res.send({
            data: exists,
            response: true
          });
        } else {
          return res.send({
            data: 'User does not exist',
            response: false
          });
        }
      });
    };
    addUser = function() {
      var user;
      user = new User({
        userid: path[0][1],
        password: path[1][1],
        active: 1
      });
      return findUser(user.userid, function(exists) {
        if (exists) {
          return res.send({
            data: 'User already exists',
            response: false
          });
        } else {
          return user.save(function(err, body) {
            if (!err) {
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
            } else {
              return console.log(err);
            }
          });
        }
      });
    };
    deleteUser = function() {
      return User.remove({
        _id: path[0][1]
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
    findUser = function(user, cb) {
      return User.find({
        userid: user
      }, function(err, docs) {
        if (!err) {
          if (docs.length) {
            return cb(docs);
          } else {
            return cb(false);
          }
        } else {
          return console.log(err);
        }
      });
    };
    switch (action) {
      case 'getInfo':
        return getInfo();
      case 'addUser':
        return addUser();
      case 'deleteUser':
        return deleteUser();
      default:
        return res.send({
          Error: 'No method found'
        });
    }
  };

}).call(this);
