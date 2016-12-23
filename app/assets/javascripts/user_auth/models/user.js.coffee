UserAuth.Models.User = Backbone.Model.extend

  urlRoot: 'users'

  validate: (attrs, ops) ->
    errors = {}
    unless attrs.name
      errors.name = ["can't be blank"]
    unless attrs.email
      errors.email = ["can't be blank"]
    unless attrs.password
      errors.password = ["can't be blank"]
    errors unless _.isEmpty errors