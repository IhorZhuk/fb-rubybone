FamilyBudget.Views.Layout.Transactions = Marionette.View.extend

  template: JST['layouts/transactions']

  regions:
    'content': '#js-region-page-content'
    'dropdown': '#js-region-dropdown'

  onBeforeRender: ->
    @collection = new FamilyBudget.Collections.Transactions()

  onRender: ->
    that = @

    @collection.fetch
      success: (collection) ->
        if collection.length > 0
          that.showChildView 'content', new FamilyBudget.Views.TransactionsTable
            collection: collection
          that.showChildView 'dropdown', new FamilyBudget.Views.Dropdown
            inputName: 'transactions_period'
            placeholder: 'this month'
            items: ['this month', 'this week', 'last month', 'this quarter']
        else
          that.showChildView 'table', new FamilyBudget.Views.TransactionsEmpty()