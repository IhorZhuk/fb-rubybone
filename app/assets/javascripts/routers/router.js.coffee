FamilyBudget.Routers.Main = Marionette.AppRouter.extend
  
  routes:
    '': 'home'
    'transactions': 'transactions'
    'add': 'add'
    'settings': 'settings'
    'search': 'search'

  onRoute: (name, path, args)->
    @trigger "navigated:#{name}"
