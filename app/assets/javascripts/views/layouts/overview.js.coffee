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
    dates = 
      date_from: FamilyBudget.Utilities.Dates.getThisMonth().from
      date_to: FamilyBudget.Utilities.Dates.getThisMonth().to

    @totals.fetch
      data: dates
    @categories.fetch
      data: dates
      
    @showChildView 'period', @periods

  fetchData: (periods)->
    @totals.fetch
      data: periods.dates
    @categories.fetch
      data: periods.dates

  showTotals: ->
    @showChildView 'totals', new FamilyBudget.Views.ChartsTotals({ model: @totals})

  showCategories: ->
    @showChildView 'categories', new FamilyBudget.Views.ChartsCategories({ model: @categories})
