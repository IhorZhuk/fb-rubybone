FamilyBudget.Views.Layout.Root = Marionette.View.extend

  template: JST['layouts/root']

  initialize: (opts) ->
    @router = opts.router
    @listenTo @router, 'navigated:home', @renderHome
    @listenTo @router, 'navigated:transactions', @renderTransactions

  regions:
    'navbar': '#js-region-navbar'
    'page': '#js-region-page'

  onRender: ->
    @showChildView 'navbar', new FamilyBudget.Views.Navbar()

  renderHome: ->
    @showChildView 'page', new FamilyBudget.Views.Layout.Home()

  renderTransactions: ->
    @showChildView 'page', new FamilyBudget.Views.Layout.Transactions()
