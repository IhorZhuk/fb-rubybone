FamilyBudget.Views.Layout.Root = Marionette.View.extend

  el: 'body'
  
  template: JST['layouts/root']

  regions:
    'navbar': '#js-region-navbar'
    'page': '#js-region-page'

  initialize: (opts) ->
    @router = opts.router
    @listenTo @router, 'navigated:home', @renderHome
    @listenTo @router, 'navigated:transactions', @renderTransactions

  onRender: ->
    @showChildView 'navbar', new FamilyBudget.Views.Navbar({router: @router})

  renderHome: ->
    @showChildView 'page', new FamilyBudget.Views.Layout.Home()

  renderTransactions: ->
    @showChildView 'page', new FamilyBudget.Views.Layout.Transactions()
    
