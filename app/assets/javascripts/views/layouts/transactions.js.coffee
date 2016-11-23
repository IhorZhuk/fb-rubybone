FamilyBudget.Views.Layout.Transactions = Marionette.View.extend

  template: JST['layouts/transactions']

  regions:
    'content': '#js-region-page-content'

  onBeforeRender: ->
    @collection = new FamilyBudget.Collections.Transactions()

  onRender: ->
    that = @
    @collection.fetch
      success: (collection) ->
        if collection.length > 0
          that.showChildView 'content', new FamilyBudget.Views.TransactionsTable
            collection: collection
        else
          that.showChildView 'table', new FamilyBudget.Views.TransactionsEmpty()