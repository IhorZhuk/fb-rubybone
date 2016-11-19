FamilyBudget.Routers.Main = Marionette.AppRouter.extend
  
  routes:
    '': 'home'
    'transactions': 'transactions'
    'add': 'add'

  onRoute: (name, path, args)->
    @trigger "navigated:#{name}"
