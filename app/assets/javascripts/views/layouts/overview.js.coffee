FamilyBudget.Views.Layout.Overview = Marionette.View.extend

  template: JST['layouts/overview']

  regions:
    'period': '#js-region-period'
    'totals': '#js-region-totals'
    'categories': '#js-region-categories'


  initialize: ->
    @totals = new FamilyBudget.Models.ChartsTotals()
    @periods =  new FamilyBudget.Views.DropdownDates()
    @listenTo @totals, 'sync', @showTotals
    @listenTo @periods, 'dropdown:updated', @fetchData

  onRender: ->
    dates = 
      date_from: FamilyBudget.Utilities.Dates.getThisMonth().from
      date_to: FamilyBudget.Utilities.Dates.getThisMonth().to

    @totals.fetch
      data: dates
      
    @showChildView 'period', @periods

  fetchData: (periods)->
    @totals.fetch
      data: periods.dates

  showTotals: ->
    @showChildView 'totals', new FamilyBudget.Views.ChartsTotals({ model: @totals})
