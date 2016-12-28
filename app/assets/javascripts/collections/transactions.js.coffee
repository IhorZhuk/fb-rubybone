FamilyBudget.Collections.Transactions = Backbone.Collection.extend

  url: 'api/transactions'

  model: FamilyBudget.Models.Transaction

  parse: (res) ->
    @pagination = res.pagination
    @totals = res.totals
    res.transactions
