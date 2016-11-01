class FamilyBudget.Views.LayoutPageHome extends Backbone.View

  template: JST['layout/page_home']

  el: '#content'

  initialize: ->
    @render()

  render: ->
    @$el.html( @template() )
    @