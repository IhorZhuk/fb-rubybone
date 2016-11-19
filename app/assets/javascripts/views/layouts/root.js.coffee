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
    @listenTo @router, 'navigated:home', @renderHome
    @listenTo @router, 'navigated:transactions', @renderTransactions
    @listenTo @router, 'navigated:add', @renderAdd

  onRender: ->
    @showChildView 'navbar', new FamilyBudget.Views.Navbar({router: @router})

  renderHome: ->
    @showChildView 'page', new FamilyBudget.Views.Layout.Home()

  renderTransactions: ->
    @showChildView 'page', new FamilyBudget.Views.Layout.Transactions()

  renderAdd: ->
    @showChildView 'page', new FamilyBudget.Views.Layout.Add()
    
