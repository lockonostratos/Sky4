// Generated by CoffeeScript 1.7.1
(function() {
  var express, router;

  express = require('express');

  router = express.Router();

  router.get('/', function(req, res) {
    return res.render('signin');
  });

  router.get('/signup', function(req, res) {
    return res.render('signup');
  });

  module.exports = router;

}).call(this);

//# sourceMappingURL=sessions.map