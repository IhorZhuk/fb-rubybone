FamilyBudget.Views.ChartsCategories = Marionette.View.extend

  template: JST['charts/charts_categories']


  ui:
    'chart': '#js-chart-categories'

  initialize: ->
    @render()

  onAttach: ->
    @renderChart()

  navigate: (e) ->
    id = e.point.id
    url = "transactions/category_id=#{id}"
    Backbone.history.navigate(url, { trigger: true})

  renderChart: ->
    debit = @model.get 'debit'
    data = _.map debit, (cat) ->
      {
        name: cat.title
        y: cat.amount
        id: cat.id
      }

    chart = new (Highcharts.Chart)(
      chart:
        renderTo: @ui.chart[0]
        type: 'pie'
      title:
        text: null
      tooltip:
        pointFormat:'{series.name}: <b>{point.percentage:.1f}%</b>'
      plotOptions:
        pie:
          allowPointerSelect: true
          cursor: 'pointer'
          dataLabels:
            enabled: true
        series:
          events:
            click: @navigate
      series: [ { 
        name: 'Share'
        data: data
      } ])