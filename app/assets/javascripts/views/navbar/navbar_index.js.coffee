class FamilyBudget.Views.NavbarIndex extends Backbone.View

  template: JST['navbar/index']

  el: '#navbar'

  events:
    'click .js-navbar-toggle': 'toggle'

  initialize: ->
    @render()

  render: ->
    @$el.html( @template() )
    @

  toggle: (e) ->
    e.preventDefault()
    @$el.toggleClass 'is-active'
