FamilyBudget.Views.Layout.Transactions = Marionette.View.extend

  template: JST['layouts/transactions']

  regions:
    'filter': '#js-region-filter'
    'content': '#js-region-page-content'

  initialize: ->
    @collection = new FamilyBudget.Collections.Transactions()

  onRender: ->
    @renderTable()
    @renderFilter()
    
  renderTable: ->
    @collection.fetch
      success: (collection) =>
        if collection.length > 0
          @showChildView 'content', new FamilyBudget.Views.TransactionsTable
            collection: collection
        else
          @showChildView 'content', new FamilyBudget.Views.TransactionsEmpty()
      changes: ''

  renderFilter: ->
    @showChildView 'filter', new FamilyBudget.Views.TransactionsFilter()