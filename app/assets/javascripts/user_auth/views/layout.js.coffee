UserAuth.Views.Layout = Marionette.View.extend
  
  el: 'body'

  template: JST['user_auth/layout']

  ui:
    'tabs': '.js-tabs'
    'alert': '.js-alert'

  regions:
    form: '#js-region-body'

  childViewEvents: ->
    'password:restored': 'passwordRestored'
    'user:created': 'userCreated'

  initialize: (ops) ->
    @router = ops.router
    @listenTo @router, 'navigated:login', @renderLoginForm
    @listenTo @router, 'navigated:register', @renderRegisterForm
    @listenTo @router, 'navigated:password_restore_email', @renderRestorePasswordEmail
    @listenTo @router, 'navigated:password_restore_form', @renderPasswordForm

  setActiveTab: (hash) ->
    @ui.tabs.find('a').removeClass 'is-active'
    @ui.tabs.find('a[href="#' + hash + '"]').addClass 'is-active'

  renderLoginForm: ->
    @resetAlert()
    @showChildView 'form', new UserAuth.Views.LoginForm()
    @setActiveTab 'login'

  renderRegisterForm: ->
    @resetAlert()
    @showChildView 'form', new UserAuth.Views.RegisterForm()
    @setActiveTab 'register'

  renderRestorePasswordEmail: ->
    @resetAlert()
    @ui.tabs.hide()
    @showChildView 'form', new UserAuth.Views.PasswordEmailForm()

  renderPasswordForm: (args) ->
    @resetAlert()
    @ui.tabs.hide()
    @showChildView 'form', new UserAuth.Views.PasswordForm
      token: args[0]

  passwordRestored: ->
    Backbone.history.navigate('login', { trigger: true})
    @resetAlert()
    @ui.alert.text('Password has been updated. Please login').show()

  userCreated: (user) ->
    Backbone.history.navigate('login', { trigger: true})
    @resetAlert()
    @ui.alert.text('User has been created. Please login').show()

  resetAlert: ->
    @ui.alert.text('').hide()

  onRender: ->
    @renderLoginForm()