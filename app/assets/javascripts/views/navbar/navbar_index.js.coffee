class FamilyBudget.Views.NavbarIndex extends Backbone.View

  template: JST['navbar/index']

  el: '#navbar'

  initialize: ->
    @render()
    _.bindAll this, 'setActiveLink'
    Backbone.history.on 'route', @setActiveLink

  render: ->
    @$el.html( @template() )
    @
  
  setActiveLink: (route, param )->
    @$el.find('a').removeClass 'is-active'
    if param == 'home'
      @$el.find('a[href="#/"]').addClass 'is-active'
    else
      @$el.find('a[href="#' + param + '"]').addClass 'is-active'