FamilyBudget.Routers.Main = Marionette.AppRouter.extend
  
  routes:
    # '': 'home'
    '': 'add'
    'transactions': 'transactions'
    'add': 'add'
    'settings': 'settings'
    'search': 'search'
    'categories': 'categories'
    'user_settings': 'user_settings'

  onRoute: (name, path, args)->
    @trigger "navigated:#{name}"
