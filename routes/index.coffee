module.exports =  (app, express, passport) ->
  router = express.Router()

  router.get '/', (req, res, next) -> res.render 'home', { title: 'Enterprise Dual Strategy' }
  router.get 'messenger', (req, res, next) -> res.render 'index', { title: 'Enterprise Dual Strategy' }

  app.use '/', router
  require('./messenger')(app, express, passport);
  require('./session')(app, express, passport);
  require('./user')(app, express, passport);
