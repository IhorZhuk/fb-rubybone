FamilyBudget.Views.Layout.Transactions = Marionette.View.extend

  template: JST['layouts/transactions']

  regions:
    'content': '#js-region-page-content'

  onRender: ->
    @showChildView 'content', new FamilyBudget.Views.TransactionsTable()