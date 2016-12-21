FamilyBudget.Collections.Transactions = Backbone.Collection.extend

  url: 'api/transactions'

  model: FamilyBudget.Models.Transaction

  parse: (res) ->
    @pagination = res.pagination
    res.transactions
