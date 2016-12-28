FamilyBudget.Views.TransactionsTable = Marionette.View.extend

  template: JST['transactions_table']

  regions:
    'pagination': '#js-region-pagination'
    'totals': '#js-region-totals'
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
    @showTotals()

  showTable: (collection) ->
    @showChildView 'body', new FamilyBudget.Views.TransactionsTableBody
      collection: collection

  showPagination: ->
    if @collection.pagination.total_pages > 1
      @showChildView 'pagination', new FamilyBudget.Views.TransactionsPagination
        collection: @collection
  
  showTotals: ->
    @showChildView 'totals', new FamilyBudget.Views.TransactionsTotals
      collection: @collection

  onRender: ->
    @renderTable()