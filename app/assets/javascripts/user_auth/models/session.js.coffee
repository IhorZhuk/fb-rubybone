UserAuth.Models.Session = Backbone.Model.extend

  urlRoot: 'login'

  validate: (attrs, ops) ->
    errors = {}

    unless attrs.email
      errors.email = ["can't be blank"]
    unless attrs.password
      errors.password = ["can't be blank"]
    
    errors unless _.isEmpty errors