UserAuth.Models.User = Backbone.Model.extend

  urlRoot: 'api/users'

  initialize: ->
    @listenTo @, 'sync', @cacheUserData

  validate: (attrs, ops) ->
    errors = {}
    unless attrs.name
      errors.name = ["can't be blank"]
    unless attrs.email
      errors.email = ["can't be blank"]
    errors unless _.isEmpty errors

  cacheUserData: (model) ->
    FamilyBudget.Cached.Currency = model.get('currency')