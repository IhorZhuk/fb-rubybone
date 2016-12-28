FamilyBudget.Views.TransactionsTotals = Marionette.View.extend

  template: JST['transactions_table_totals']

  initialize: (ops) ->
    @totals = ops.collection.totals
  
  render: ->
    @$el.html( @template(@totals) )
