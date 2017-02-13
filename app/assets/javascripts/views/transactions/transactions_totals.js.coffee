FamilyBudget.Views.TransactionsTotals = Marionette.View.extend

  template: JST['transactions/transactions_table_totals']

  initialize: (ops) ->
    @collection = ops.collection

  render: ->
    @$el.html( @template(@collection.totals) )