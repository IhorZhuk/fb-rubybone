FamilyBudget.Views.TransactionsTotals = Marionette.View.extend

  template: JST['transactions/transactions_table_totals']

  initialize: (ops) ->
    @totals = ops.totals
    @totals.currency = FamilyBudget.Cached.Currency

  render: ->
    @$el.html( @template(@totals) )