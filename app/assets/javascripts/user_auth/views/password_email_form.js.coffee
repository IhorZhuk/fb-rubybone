UserAuth.Views.PasswordEmailForm = Marionette.View.extend

  template: JST['user_auth/password_email_form']

  ui:
    'alert': '.js-notice'
    'error': '.js-error'
    'email': 'input[name="email"]'

  events:
    'submit': 'submit'

  initialize: ->
    Cocktail.mixin @, FamilyBudget.Utilities.ValidationHandler

  submit: (e) ->
    e.preventDefault()
    @createModel()
    @resetInvalidInputs()

    if @model.isValid()
      console.log @model
      @model.save null, success: =>
        @ui.alert.slideDown 150
    else
      @renderErrors()

  createModel: ->
    @model = new UserAuth.Models.PasswordReset
      email: @ui.email.val()

    @listenTo @model, 'invalid', @renderErrors
    @listenTo @model, 'error', @parseErrorResponse
