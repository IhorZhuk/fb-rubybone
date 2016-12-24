FamilyBudget.Routers.Main = Marionette.AppRouter.extend
  
  routes:
    # '': 'home'
    '': 'add'
    'transactions': 'transactions'
    'add': 'add'
    'settings': 'settings'
    'search': 'search'

  onRoute: (name, path, args)->
    @trigger "navigated:#{name}"
