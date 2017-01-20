FamilyBudget.Views.Layout.Overview = Marionette.View.extend

  template: JST['layouts/overview']

  regions:
    'totals': '#js-region-totals'
    'categories': '#js-region-categories'

  initialize: ->
    @totals = new FamilyBudget.Models.ChartsTotals()
    @listenTo @totals, 'sync', @showTotals

  onRender: ->
    @totals.fetch()

  showTotals: ->
    @showChildView 'totals', new FamilyBudget.Views.ChartsTotals({ model: @totals})
