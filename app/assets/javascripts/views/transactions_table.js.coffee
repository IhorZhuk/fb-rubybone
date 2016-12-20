FamilyBudget.Views.TransactionsTable = Marionette.View.extend

  template: JST['transactions_table']

  regions:
    'pagination': '#js-region-pagination'
    body: 
      el: '.js-tbody'
      replaceElement: true

  ui:
    'table': '.table-transactions'

  childViewEvents: 
    'pagination:clicked': 'nextPage'

  initialize: (ops) ->
    @collection = ops.collection
    
  nextPage: (page) ->
    @collection = new FamilyBudget.Collections.Transactions()
    @listenTo @collection, 'reset', @renderTable
    @collection.fetch
      error: (e) ->
        console.log e
      reset: true
      data: 
        page: page

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