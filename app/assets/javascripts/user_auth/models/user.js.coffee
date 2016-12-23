UserAuth.Models.User = Backbone.Model.extend

  urlRoot: 'users'

  # validate: (attrs, ops) ->
  #   errors = {}
  #   unless attrs.name
  #     errors.title = ["can't be blank"]
  #   unless attrs.email
  #     errors.email = ["can't be blank"]
  #   unless attrs.password
  #     errors.password = ["can't be blank"]
  #   if attrs.password != attrs.password_confimration
  #     errors.confimration = ['doesn\'t match']
  #   errors unless _.isEmpty errors