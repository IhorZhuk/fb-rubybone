FamilyBudget.Views.Layout.Overview = Marionette.View.extend

  template: JST['layouts/overview']

  regions:
    'period': '#js-region-period'
    'totalsChart': '#js-region-totals-chart'
    'totals':'#js-region-total-numbers'
    'categories': '#js-region-categories'


  initialize: ->
    @totals = new FamilyBudget.Models.ChartsTotals()
    @categories = new FamilyBudget.Models.ChartsCategories()
    @periods =  new FamilyBudget.Views.DropdownDates()
    @listenTo @totals, 'sync', @showTotals
    @listenTo @categories, 'sync', @showCategories
    @listenTo @periods, 'dropdown:updated', @fetchData

  onRender: ->
    period = FamilyBudget.Utilities.Dates.getThisMonth()

    @fetchData period
    @showChildView 'period', @periods

  prepareFormat: (period)->
      date_from: period.from,
      date_to: period.to

  fetchData: (periods)->
    dates = @prepareFormat periods
    @totals.fetch
      data: dates
    @categories.fetch
      data: dates

  showTotals: ->
    @showChildView 'totalsChart', new FamilyBudget.Views.ChartsTotals({ model: @totals})
    numbers =
      totals: @totals.toJSON()
    @showChildView 'totals', new FamilyBudget.Views.TransactionsTotals({ collection: numbers })

  showCategories: ->
    @showChildView 'categories', new FamilyBudget.Views.ChartsCategories({ model: @categories})
