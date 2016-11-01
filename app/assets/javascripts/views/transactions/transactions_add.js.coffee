class FamilyBudget.Views.TransactionsAdd extends Backbone.View

  template: JST['transactions/add']

  el: '.js-page-add-left-col'

  initialize: ->
    @render()

  render: ->
    @$el.html( @template() )
    @
