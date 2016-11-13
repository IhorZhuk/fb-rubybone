class FamilyBudget.Views.LayoutPageAdd extends Backbone.View

  template: JST['layout/page_add']

  el: '#content'

  initialize: ->
    @render()

  render: ->
    @$el.html( @template() )
    @
