FamilyBudget.Routers.Main = Marionette.AppRouter.extend
  
  routes:
    '': 'home'
    'transactions': 'transactions'

  onRoute: (name, path, args)->
    @trigger "navigated:#{name}"
