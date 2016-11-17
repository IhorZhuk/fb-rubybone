FamilyBudget.Collections.Transactions = Backbone.Collection.extend

  url: 'api/transactions'

  model: FamilyBudget.Models.Transaction

  sortKey: 'date'

  comparator: (model) ->
    model.get @sortKey
