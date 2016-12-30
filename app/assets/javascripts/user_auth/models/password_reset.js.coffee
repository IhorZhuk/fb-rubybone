UserAuth.Models.PasswordReset = Backbone.Model.extend

  urlRoot: 'api/password_resets'

  validate: (attrs, ops) ->
    errors = {}

    unless attrs.email
      errors.email = ["can't be blank"]
    
    errors unless _.isEmpty errors