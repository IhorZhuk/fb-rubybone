FamilyBudget.Views.Layout.Transactions = Marionette.View.extend

  template: JST['layouts/transactions']

  regions:
    'filter': '#js-region-filter'
    'content': '#js-region-page-content'
    'totals': '#js-region-totals'

  initialize: ->
    @collection = new FamilyBudget.Collections.Transactions()
    @filterView = new FamilyBudget.Views.TransactionsFilter()
    @listenTo FamilyBudget.Channels.transactionsTable, 'pagination:clicked', @onPaginationClick
    @listenTo FamilyBudget.Channels.transactionsTable, 'filter:clicked', @onFilterClick

  onRender: ->
    date = 
      date_from: FamilyBudget.Utilities.Dates.getThisMonth().from
      date_to: FamilyBudget.Utilities.Dates.getThisMonth().to
      order: 'date'
      direction: 'DESC'

    @renderContent date
    @renderFilter()
    
  renderContent: (data) ->
    @collection.fetch
      success: (collection) =>
        if collection.length > 0
          @showChildView 'content', new FamilyBudget.Views.TransactionsTable
            collection: collection
          @showChildView 'totals', new FamilyBudget.Views.TransactionsTotals
            totals: collection.totals
        else
          @showChildView 'content', new FamilyBudget.Views.TransactionsEmpty
            message: 'There no transactions according to your search criteria'
      data: data
      changes: ''
      reset: true

  renderFilter: ->
    @showChildView 'filter', @filterView

  onFilterClick: (filters) ->
    @renderContent filters

  onPaginationClick: (page) ->
    filters = @filterView.getCurrentState()
    filters.page = page
    @renderContent filters

