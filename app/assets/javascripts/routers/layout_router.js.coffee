class FamilyBudget.Routers.Layout extends Backbone.Router

  routes:
    ''             :   'home'
    'add'          :   'add'
    'transactions' :   'transactions'

  home: ->
    new FamilyBudget.Views.LayoutPageHome()

  add: ->
    transactions = new FamilyBudget.Collections.Transactions()
    new FamilyBudget.Views.LayoutPageAdd()
    new FamilyBudget.Views.TransactionsAdd({ collection: transactions})
    new FamilyBudget.Views.TransactionsTableToday({ collection: transactions})

  transactions: ->
    transactions = new FamilyBudget.Collections.Transactions()
    new FamilyBudget.Views.LayoutPageTransactions()
    new FamilyBudget.Views.TransactionsTableAll({ collection: transactions })