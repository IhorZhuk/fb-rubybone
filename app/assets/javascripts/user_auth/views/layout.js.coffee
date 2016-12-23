UserAuth.Views.Layout = Marionette.View.extend
  
  el: 'body'

  template: JST['user_auth/layout']

  ui:
    'tabs': '.js-tabs'

  regions:
    form: '#js-region-body'

  initialize: (ops) ->
    @router = ops.router
    @listenTo @router, 'navigated:login', @renderLoginForm
    @listenTo @router, 'navigated:register', @renderRegisterForm

  setActiveTab: (hash) ->
    @ui.tabs.find('a').removeClass 'is-active'
    @ui.tabs.find('a[href="#' + hash + '"]').addClass 'is-active'

  renderLoginForm: ->
    @showChildView 'form', new UserAuth.Views.LoginForm()
    @setActiveTab 'login'

  renderRegisterForm: ->
    @showChildView 'form', new UserAuth.Views.RegisterForm()
    @setActiveTab 'register'

  onRender: ->
    @renderLoginForm()
    