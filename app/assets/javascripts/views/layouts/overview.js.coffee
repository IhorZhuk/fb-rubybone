FamilyBudget.Views.Layout.Overview = Marionette.View.extend

  template: JST['layouts/overview']

  regions:
    'period': '#js-region-period'
    'totals': '#js-region-totals'
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
    @showChildView 'totals', new FamilyBudget.Views.ChartsTotals({ model: @totals})

  showCategories: ->
    @showChildView 'categories', new FamilyBudget.Views.ChartsCategories({ model: @categories})
