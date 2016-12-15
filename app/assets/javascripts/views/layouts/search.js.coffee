FamilyBudget.Views.Layout.Search = Marionette.View.extend

  template: JST['layouts/search']

  regions:
    'form' : '#js-region-form'
    'results': '#js-region-results'

  initialize: ->
    @collection = new FamilyBudget.Collections.Transactions()
    @listenTo @collection, 'update', @renderResults

  onRender: ->
    @showChildView 'form', new FamilyBudget.Views.TransactionsFormSearch
      collection: @collection
    @renderResults()

  renderResults: ->
    console.log 'reulsts'