User = require '../models/user'
Merchant = require '../models/merchant'

module.exports =  (app, express, passport) ->
  router = express.Router()

  router.get '/', (req, res, next) ->
    res.render 'home', { title: 'Enterprise Dual Strategy' }

  router.get '/merc', (req, res) ->
    merc = new Merchant()
    merc.name = 'Huỳnh Châu'
    merc.save (error) ->
      throw error if error
      res.send merc

  router.get  '/login', (req, res, next) ->
    res.redirect '/' if req.isAuthenticated()
    res.render 'login', { message: req.flash 'loginMessage' }

  router.post '/login', passport.authenticate('local-login',
    successRedirect : '/'
    failureRedirect : '/login'
    failureFlash : true
  )

  router.get '/logout', (req, res) -> req.logout(); res.redirect '/login'

  router.get  '/signup', (req, res, next) ->
    console.log req.isAuthenticated()
    res.redirect '/' if req.isAuthenticated()
    res.render 'signup', { message: req.flash('signupMessage') }

  router.post '/signup', passport.authenticate('local-signup',
    successRedirect : '/'
    failureRedirect : '/signup'
    failureFlash : true
  )

  router.get 'messenger', (req, res, next) -> res.render 'index', { title: 'Enterprise Dual Strategy' }

  app.use '/', router
  require('./messenger')(app, express, passport);
  require('./session')(app, express, passport);
  require('./user')(app, express, passport);
