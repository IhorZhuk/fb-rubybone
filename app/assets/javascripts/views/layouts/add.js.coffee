FamilyBudget.Views.Layout.Add = Marionette.View.extend

  template: JST['layouts/add']

  regions:
    'form': '#js-region-form'
    'table': '#js-region-table'

  childViewEvents:
    'form:submited': 'renderTable'

  initialize: ->
    @collection = new FamilyBudget.Collections.Transactions()
    @filters = 
      created_at: new Date()
    @listenTo FamilyBudget.Channels.transactionsTable, 'pagination:clicked', @onPaginationClick
    @listenTo @collection, 'reset', @renderTable
    @fetchCollection @filters

  fetchCollection: (data) ->
    @collection.fetch
      error: (e) ->
        console.log e
      data: data
      reset: true

  onRender: ->
    @showChildView 'form', new FamilyBudget.Views.TransactionsFormAdd
      collection: @collection

  renderTable: ->
    if @collection.length > 0
      @showChildView 'table', new FamilyBudget.Views.TransactionsTable
        collection: @collection
    else
      @showChildView 'table', new FamilyBudget.Views.TransactionsEmpty
        message: 'You haven\'t added any transactions today'

  onPaginationClick: (page) ->
    @filters.page = page
    # TODO
    # if don't use destroy there is an error
    @getChildView('table').destroy()
    @fetchCollection @filters