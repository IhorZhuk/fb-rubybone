FamilyBudget.Views.TransactionsTotals = Marionette.View.extend

  template: JST['transactions/transactions_table_totals']

  initialize: (ops) ->
    @totals = ops.totals
    if ops.currency? then @totals.currency = ops.currency

  render: ->
    @$el.html( @template(@totals) )