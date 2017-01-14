FamilyBudget.Views.Navbar = Marionette.View.extend
  
  template: JST['navbar/navbar']

  ui:
    'wrapper': '.navbar'
    'navbar': '.navbar-list'
    'links': '.navbar-list a'
    'toggle': '.js-navbar-toggle'
    'overlay': '.js-navbar-overlay'

  events: 
    'click @ui.toggle': 'toggleNavbar'
    'click @ui.overlay': 'toggleNavbar'
    'click @ui.links': 'resetNavbar'

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

  toggleNavbar: ->
    @ui.wrapper.toggleClass 'is-active'
    @ui.overlay.toggleClass 'is-active'

  resetNavbar: ->
    @ui.wrapper.removeClass('is-active') if @ui.wrapper.hasClass('is-active')
    @ui.overlay.removeClass('is-active') if @ui.overlay.hasClass('is-active')