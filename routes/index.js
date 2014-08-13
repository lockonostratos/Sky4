var express = require('express');
var router = express.Router();

router.get('/', function(req, res) {
  res.render('home', { title: 'Enterprise Dual Strategy' });
});

router.get('/messenger', function(req, res) {
  res.render('index', { title: 'Enterprise Dual Strategy' });
});

module.exports = router;
