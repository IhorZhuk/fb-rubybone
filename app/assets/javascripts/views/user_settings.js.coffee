FamilyBudget.Views.UserSettings = Marionette.View.extend

  template: JST['user_settings']

  ui:
    'name': 'input[name="name"]'
    'email': 'input[name="email"]'
    'password': 'input[name="password"]'
    'passwordConfirm': 'input[name="password_confirm"]'
    'deleteToggle':'.js-delete-toggle'
    'deleteAlert': '.js-delete-alert'
    'deleteBtn': '.js-delete-btn'
    'error': '.js-error'
    'success': '.js-success'

  events:
    'submit form': 'submit'
    'click @ui.deleteToggle': 'toggleDeleteAlert'
    'click @ui.deleteBtn':'deleteUser'

  initialize: ->
    Cocktail.mixin @, FamilyBudget.Utilities.ValidationHandler
    @user = FamilyBudget.user
    @listenTo @user, 'destroy', @showLoginScreen
    @listenTo @user, 'invalid', @renderErrors
    @listenTo @user, 'error', @parseErrorResponse
    @listenTo @user, 'sync', @renderMessage

  onRender: ->
    @setValues()

  setValues: ->
    user = @user.toJSON()
    @ui.name.val user.name
    @ui.email.val user.email

  toggleDeleteAlert: ->
    @ui.deleteAlert.slideToggle 150

  deleteUser: ->
    @user.destroy()

  showLoginScreen: ->
    window.location.href = '/login'

  renderMessage: ->
    @ui.success.text('Saved').show()

  submit: (e) ->
    e.preventDefault()
    @ui.success.hide().text ''
    @resetInvalidInputs()
    @user.set
      name: @ui.name.val()
      email: @ui.email.val()
      password: @ui.password.val()
      password_confirmation: @ui.passwordConfirm.val()
    @user.save()
    