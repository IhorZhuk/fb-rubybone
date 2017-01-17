FamilyBudget.Views.Layout.Overview = Marionette.View.extend

  template: JST['layouts/overview']

  regions:
    'totals': '#js-region-totals'
    'categories': '#js-region-categories'

  onRender: ->
    @showChildView 'totals', new FamilyBudget.Views.ChartsTotals()
