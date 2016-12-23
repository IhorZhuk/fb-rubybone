UserAuth.Routers.Main = Marionette.AppRouter.extend

  routes:
    '': 'login'
    'login': 'login'
    'register': 'register'

  onRoute: (name, path, args)->
    @trigger "navigated:#{name}"