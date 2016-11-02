class FamilyBudget.Routers.Layout extends Backbone.Router

  routes:
    ''        :    'homePage'
    'add'     :    'addPage'


  homePage: ->
    new FamilyBudget.Views.LayoutPageHome()

  addPage: ->
    transactions = new FamilyBudget.Collections.Transactions()
    console.log transactions
    new FamilyBudget.Views.LayoutPageAdd()
    new FamilyBudget.Views.TransactionsAdd({ collection: transactions})
    new FamilyBudget.Views.TransactionsTable({ collection: transactions})
