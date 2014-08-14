module.exports =  (app, express, passport) ->
  user = express.Router()
  mongoose = require 'mongoose'
  User = mongoose.model 'users', {name: String}

  user.get '/profile', Authenticated, (req, res, next) ->
    User.find (err, users) -> res.send users

  app.use '/user', user

Authenticated = (req, res, next) ->
  if req.isAuthenticated() then next()
  res.redirect '/session'