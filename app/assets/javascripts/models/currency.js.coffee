FamilyBudget.Models.Currency = Backbone.Model.extend

  urlRoot: 'api/currencies'

  validate: (attrs, ops) ->
    errors = {}

    unless attrs.title
      errors.title = ["can't be blank"]
    
    errors unless _.isEmpty errors