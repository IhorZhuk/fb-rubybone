FamilyBudget.Views.Layout.Add = Marionette.View.extend

  template: JST['layouts/add']

  regions:
    'form': '#js-region-form'
    'table': '#js-region-table'

  childViewEvents:
    'model:saved': 'render'

  initialize: ->
    @collection = new FamilyBudget.Collections.Transactions()
    @listenTo @collection, 'update', @renderTable 

  onRender: ->
    @showChildView 'form', new FamilyBudget.Views.TransactionsFormAdd()
    @renderTable()

  renderTable: ->
    @collection.fetch
      success: (collection) =>
        if collection.length > 0
          @showChildView 'table', new FamilyBudget.Views.TransactionsTable
            collection: collection
        else
          @showChildView 'table', new FamilyBudget.Views.TransactionsEmpty()

      error: (e) ->
        console.log e
      data: 
        date_from: new Date()