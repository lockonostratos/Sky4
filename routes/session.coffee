express = require 'express'
router = express.Router()

router.get '/', (req, res) ->
  res.render 'login'

router.post '/create', (req, res) ->
  res.send req.body

module.exports = router