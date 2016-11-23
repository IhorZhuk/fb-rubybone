FamilyBudget.Views.TransactionsTable = Marionette.View.extend

  tagName: 'table'

  className: 'table-main'

  template: JST['transactions_table']

  regions:
    body: 
      el: 'tbody'
      replaceElement: true

  initialize: (ops) ->
    @collection = ops.collection

  onRender: ->
    @showChildView 'body', new FamilyBudget.Views.TransactionsTableBody
      collection: @collection
