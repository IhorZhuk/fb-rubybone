FamilyBudget.Views.TransactionsTable = Marionette.View.extend

  template: JST['transactions_table']

  regions:
    'pagination': '#js-region-pagination'
    body: 
      el: '.js-tbody'
      replaceElement: true

  ui:
    'table': '.table-transactions'

  initialize: (ops) ->
    @collection = ops.collection

  renderTable: ->
    @showTable @collection
    @showPagination()

  showTable: (collection) ->
    @showChildView 'body', new FamilyBudget.Views.TransactionsTableBody
      collection: collection

  showPagination: ->
    @showChildView 'pagination', new FamilyBudget.Views.TransactionsPagination
      collection: @collection

  onRender: ->
    @renderTable()