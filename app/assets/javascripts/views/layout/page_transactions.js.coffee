class FamilyBudget.Views.LayoutPageTransactions extends Backbone.View

  template: JST['layout/page_transactions']

  el: '#content'

  initialize: ->
    @render()

  render: ->
    @$el.html( @template() )
    @
