FamilyBudget.Routers.Main = Marionette.AppRouter.extend
  
  routes:
    '': 'home'
    'transactions': 'transactions'
    'add': 'add'
    'settings': 'settings'

  onRoute: (name, path, args)->
    @trigger "navigated:#{name}"
