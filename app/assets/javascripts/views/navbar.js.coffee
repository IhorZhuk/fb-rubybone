FamilyBudget.Views.Navbar = Marionette.View.extend

  className: 'navbar'
  
  template: JST['navbar']

  ui:
    'navbar': '.navbar-list'
    'links': '.navbar-list a'

  regions:
    user: 
      el: '#js-region-user'
      replaceElement: true

  initialize: (opts) ->
    @router = opts.router
    @listenTo FamilyBudget.user, 'sync', @renderUserBar
    @listenTo @router, 'route', @setActiveLink

    FamilyBudget.user.fetch()

  renderUserBar: ->
    @showChildView 'user', new FamilyBudget.Views.NavbarUser
      model: FamilyBudget.user

  setActiveLink: (name, path, args) ->
    @ui.links.removeClass 'is-active'
    @ui.navbar.find('a[data-name="'+ name + '"]').addClass 'is-active'