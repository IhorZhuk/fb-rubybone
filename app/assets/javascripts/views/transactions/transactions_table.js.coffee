FamilyBudget.Views.TransactionsTable = Marionette.View.extend

  template: JST['transactions/transactions_table']

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
    @showTable()
    @showPagination()

  showTable: ->
    @showChildView 'body', new FamilyBudget.Views.TransactionsTableBody
      collection: @collection

  showPagination: ->
    if @collection.pagination.total_pages > 1
      @showChildView 'pagination', new FamilyBudget.Views.TransactionsPagination
        collection: @collection

  onRender: ->
    @renderTable()