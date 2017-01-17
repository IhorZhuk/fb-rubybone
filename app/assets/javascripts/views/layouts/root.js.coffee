FamilyBudget.Views.Layout.Root = Marionette.View.extend

  el: 'body'
  
  template: JST['layouts/root']

  regions:
    navbar: 
      el: '#js-region-navbar'
      replaceElement: true
    page: '#js-region-page'


  initialize: (opts) ->
    @router = opts.router
    @listenTo @router, 'navigated:overview', @renderOverview
    @listenTo @router, 'navigated:transactions', @renderTransactions
    @listenTo @router, 'navigated:add', @renderAdd
    @listenTo @router, 'navigated:categories', @renderCategories
    @listenTo @router, 'navigated:user_settings', @renderUserSettings

  onRender: ->
    @showChildView 'navbar', new FamilyBudget.Views.Navbar({router: @router})

  renderOverview: ->
    @showChildView 'page', new FamilyBudget.Views.Layout.Overview()

  renderTransactions: ->
    @showChildView 'page', new FamilyBudget.Views.Layout.Transactions()

  renderAdd: ->
    @showChildView 'page', new FamilyBudget.Views.Layout.Add()

  renderCategories: ->
    @showChildView 'page', new FamilyBudget.Views.Layout.Categories()

  renderUserSettings: ->
    @showChildView 'page', new FamilyBudget.Views.Layout.UserSettings()
