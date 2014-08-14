module.exports =  (app, express, passport) ->
  session = express.Router()

  session.get  '/', (req, res, next) -> res.render 'login'
  session.post '/', passport.authenticate('local-login',
    successRedirect : '/test'
    failureRedirect : '/session'
    failureFlash : true
  )

  session.get  '/signup', (req, res, next) -> res.render 'signup', { message: req.flash('signupMessage') }
  session.post '/signup', passport.authenticate('local-signup',
    successRedirect : '/'
    failureRedirect : '/session/signup'
    failureFlash : true
  )

  app.use '/session', session
