UserAuth.Views.RegisterForm = Marionette.View.extend

  tagName: 'form'
  
  template: JST['user_auth/register_form']

  ui:
    'name': 'input[name="name"]'
    'email': 'input[name="email"]'
    'password': 'input[name="password"]'
    'passwordConfirm': 'input[name="password_confirm"]'
    'error': '.js-error'

  events:
    'submit': 'submit'

  initialize: ->
    Cocktail.mixin @, FamilyBudget.Utilities.ValidationHandler

  submit: (e) ->
    e.preventDefault()
    @createUser()
    @resetInvalidInputs()
    if @user.isValid()
      @user.save null, success: (model, res) =>
        @triggerMethod 'user:created', @user
    else
      @renderErrors()

  createUser: ->
    @user = new UserAuth.Models.User
      name: @ui.name.val()
      email: @ui.email.val()
      password: @ui.password.val()
      password_confirmation: @ui.passwordConfirm.val()

    @listenTo @user, 'invalid', @renderErrors
    @listenTo @user, 'error', @parseErrorResponse