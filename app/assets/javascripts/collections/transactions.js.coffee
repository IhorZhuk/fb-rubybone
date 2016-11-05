class FamilyBudget.Collections.Transactions extends Backbone.Collection

  url: 'api/transactions'

  model: FamilyBudget.Models.Transaction

  sortKey: 'date'

  comparator: (model) ->
    model.get @sortKey
