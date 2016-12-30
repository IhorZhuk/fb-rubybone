UserAuth.Views.PasswordForm = Marionette.View.extend

  template: JST['user_auth/password_form']

  ui:
    'error': '.js-error'
    'email': 'input[name="email"]'
    'password': 'input[name="password"]'
    'passwordConfirm': 'input[name="password_confirmation"]'

  events:
    'submit': 'submit'

  initialize: (ops) ->
    @token = ops.token
    Cocktail.mixin @, FamilyBudget.Utilities.ValidationHandler

  submit: (e) ->
    e.preventDefault()
    @createModel()
    @resetInvalidInputs()

    if @model.isValid()
      @model.save null, success: =>
        @triggerMethod 'password:restored'
    else
      @renderErrors()

  createModel: ->
    @model = new UserAuth.Models.PasswordReset
      id: @token
      password: @ui.password.val()
      password_confirmation: @ui.passwordConfirm.val()
      email: @ui.email.val()

    @listenTo @model, 'invalid', @renderErrors
    @listenTo @model, 'error', @parseErrorResponse