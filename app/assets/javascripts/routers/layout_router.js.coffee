class FamilyBudget.Routers.Layout extends Backbone.Router

  routes:
    ''        :    'home'
    'add'     :    'add'

  home: ->
    new FamilyBudget.Views.LayoutPageHome()

  add: ->
    transactions = new FamilyBudget.Collections.Transactions()

    new FamilyBudget.Views.LayoutPageAdd()
    new FamilyBudget.Views.TransactionsAdd({ collection: transactions})
    new FamilyBudget.Views.TransactionsTable({ collection: transactions})
