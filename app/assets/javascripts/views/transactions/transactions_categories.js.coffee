FamilyBudget.Views.TransactionCategories = Marionette.View.extend

  template: JST['transactions/transactions_categories']

  serializeData: ->
    data = @model.toJSON()
    data.currency = FamilyBudget.Cached.Currency
    data