module.exports =  (app, express, passport) ->
  user = express.Router()
  mongoose = require 'mongoose'
  User = require '../models/user'

  user.get '/profile', Authenticated, (req, res) ->
    res.send req.user

  app.use '/user', user

Authenticated = (req, res, next) ->
  console.log req.isAuthenticated()
  return next() if req.isAuthenticated()
  res.redirect '/session/login';