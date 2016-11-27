FamilyBudget.Views.Layout.Add = Marionette.View.extend

  template: JST['layouts/add']

  regions:
    'form': '#js-region-form'
    'table': '#js-region-table'

  childViewEvents:
    'model:saved': 'render'

  onBeforeRender: ->
    @collection = new FamilyBudget.Collections.Transactions()

  onRender: ->
    @showChildView 'form', new FamilyBudget.Views.TransactionsFormAdd()

    that = @
    @collection.fetch
      success: (collection) ->
        console.log collection
        if collection.length > 0
          that.showChildView 'table', new FamilyBudget.Views.TransactionsTable
            collection: collection
        else
          that.showChildView 'table', new FamilyBudget.Views.TransactionsEmpty()

      error: (e) ->
        console.log e
      data: 
        date_from: new Date()