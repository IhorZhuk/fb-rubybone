FamilyBudget.Views.Layout.Add = Marionette.View.extend

  template: JST['layouts/add']

  regions:
    'form': '#js-region-form'
    'table': '#js-region-table'

  initialize: ->
    @collection = new FamilyBudget.Collections.Transactions()
    @collection.fetch
      error: (e) ->
        console.log e
      data: 
        created_at: new Date()
      reset: true
    @listenTo @collection, 'update', @renderTable
    @listenTo @collection, 'reset', @renderTable

  onRender: ->
    @showChildView 'form', new FamilyBudget.Views.TransactionsFormAdd
      collection: @collection

  renderTable: ->
    if @collection.length > 0
      @showChildView 'table', new FamilyBudget.Views.TransactionsTable
        collection: @collection
    else
      @showChildView 'table', new FamilyBudget.Views.TransactionsEmpty()