FamilyBudget.Views.ChartsTotals = Marionette.View.extend

  template: JST['charts/charts_totals']

  ui:
    'chart': '#js-chart-totals'

  initialize: ->
    @render()

  onAttach: ->
    @renderChart()

  renderChart: ->
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
          showInLegend: true
      legend:
        itemStyle:
          fontSize:'15px'
          fontWeight: 'normal'
          color: FamilyBudget.Colors.font
        labelFormat:'<b>{name}</b> - {percentage}%'
      series: [ { 
        name: 'Share'
        data: [
          {
            name: 'Debit'
            y: @model.get('debit')
            color: FamilyBudget.Colors.red
            sliced: true
          }
          {
            name: 'Credit'
            y: @model.get('credit')
            color: FamilyBudget.Colors.green
          }
        ] 
      } ])

    chart.reflow()