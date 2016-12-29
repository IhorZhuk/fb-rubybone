UserAuth.Views.LoginForm = Marionette.View.extend

  tagName: 'form'

  template: JST['user_auth/login_form']

  ui:
    'email': 'input[name="email"]'
    'password': 'input[name="password"]'
    'remember': 'input[name="remember_me"]'
    'error': '.js-error'

  events:
    'submit': 'submit'

  initialize: ->
    Cocktail.mixin @, FamilyBudget.Utilities.ValidationHandler

  submit: (e) ->
    e.preventDefault()
    @createSession()
    @resetInvalidInputs()
    if @session.isValid()
      @session.save null, success: (model, res) =>
        window.location.href = '../'
    else
      @renderErrors()

  createSession: ->
    if @ui.remember.is(':checked')
      remember = 'on'
    else
      remember = 'off'
    @session = new UserAuth.Models.Session
      email: @ui.email.val()
      password: @ui.password.val()
      remeber_me: remember
    
    @listenTo @session, 'invalid', @renderErrors
    @listenTo @session, 'error', @parseErrorResponse