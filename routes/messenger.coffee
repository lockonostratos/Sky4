module.exports =  (app, express, passport) ->
  messenger = express.Router()


  app.use '/messenger', messenger