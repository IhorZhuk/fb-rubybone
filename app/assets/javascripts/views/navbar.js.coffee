FamilyBudget.Views.Navbar = Marionette.View.extend

  className: 'navbar'
  
  template: JST['navbar']

  ui:
    'navbar': '.navbar-list'
    'links': '.navbar-list a'

  initialize: (opts) ->
    @router = opts.router
    @listenTo @router, 'route', @setActiveLink

  setActiveLink: (name, path, args) ->
    @ui.links.removeClass 'is-active'
    @ui.navbar.find('a[data-name="'+ name + '"]').addClass 'is-active'
