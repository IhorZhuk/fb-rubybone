UserAuth.Views.LoginForm = Marionette.View.extend

  tagName: 'form'

  template: JST['user_auth/login_form']

  ui:
    'email': 'input[name="email"]'
    'password': 'input[name="password"]'

  events:
    'submit': 'submit'

  submit: (e) ->
    e.preventDefault()
    @createSession()
    @session.save()

  createSession: ->
    @session = new UserAuth.Models.Session
      email: @ui.email.val()
      password: @ui.password.val()