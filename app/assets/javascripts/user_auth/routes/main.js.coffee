UserAuth.Routers.Main = Marionette.AppRouter.extend

  routes:
    '': 'login'
    'login': 'login'
    'register': 'register'
    'password_restore_email': 'password_restore_email'
    'password_restore_form/:id': 'password_restore_form'

  onRoute: (name, path, args)->
    @trigger "navigated:#{name}", args