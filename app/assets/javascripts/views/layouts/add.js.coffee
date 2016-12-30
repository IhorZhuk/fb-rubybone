FamilyBudget.Views.Layout.Add = Marionette.View.extend

  template: JST['layouts/add']

  regions:
    'form': '#js-region-form'
    'table': '#js-region-table'
    'totals': '#js-region-totals'

  childViewEvents:
    'form:submited': 'fetchCollection'

  initialize: ->
    @collection = new FamilyBudget.Collections.Transactions()
    @filters = 
      created_at: new Date()
    @listenTo FamilyBudget.Channels.transactionsTable, 'pagination:clicked', @onPaginationClick
    @listenTo FamilyBudget.Channels.transactionsTable, 'transaction:edited', @updateCollection
    @listenTo @collection, 'reset', @renderContent
    @listenTo @collection, 'update', @updateCollection
    @fetchCollection @filters

  updateCollection: ->
    @fetchCollection @filters

  fetchCollection: (data) ->
    unless data?
      data = @filters

    @destroyContent()
    @collection.fetch
      error: (e) ->
        console.log e
      data: data
      reset: true

  onRender: ->
    @showChildView 'form', new FamilyBudget.Views.TransactionsFormAdd
      collection: @collection

  renderContent: ->
    if @collection.length > 0
      @showChildView 'table', new FamilyBudget.Views.TransactionsTable
        collection: @collection
      @showChildView 'totals', new FamilyBudget.Views.TransactionsTotals
        collection: @collection
    else
      @showChildView 'table', new FamilyBudget.Views.TransactionsEmpty
        message: 'You haven\'t added any transactions today'

  destroyContent: ->
    table = @getChildView 'table'
    totals = @getChildView 'totals'
    if table? and totals?
      table.destroy()
      totals.destroy()

  onPaginationClick: (page) ->
    @filters.page = page
    @destroyContent()
    @fetchCollection @filters