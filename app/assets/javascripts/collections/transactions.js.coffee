FamilyBudget.Collections.Transactions = Backbone.Collection.extend

  url: 'api/transactions'

  model: FamilyBudget.Models.Transaction

  sortKey: 'date'

  parse: (res) ->
    @pagination = res.pagination
    res.transactions

  comparator: (model) ->
    model.get @sortKey
