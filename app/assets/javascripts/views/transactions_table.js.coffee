FamilyBudget.Views.TransactionsTable = Marionette.View.extend

  tagName: 'table'

  className: 'table-main'

  template: JST['transactions_table']

  regions:
    body: 
      el: 'tbody'
      replaceElement: true

  onBeforeRender: ->
    @collection = new FamilyBudget.Collections.Transactions()

  onRender: ->
    that = @
    @collection.fetch
      success: ->
        that.showChildView 'body', new FamilyBudget.Views.TransactionsTableBody({collection: that.collection})