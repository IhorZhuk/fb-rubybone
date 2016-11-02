class FamilyBudget.Views.TransactionsTable extends Backbone.View

  template: JST['transactions/table']

  el: '.js-page-add-right-col'

  initialize: ->
    _.bindAll this, 'render'
    @collection.fetch({success: @render})
    @listenTo Backbone, 'transactionAdded', @render
    

  render: ->
    @$el.html( @template() )

    tbody = @$el.find('tbody')
    tbody.html('')

    @collection.each (model) ->
      row = new FamilyBudget.Views.TransactionsTableRow({ model: model})
      tbody.prepend( row.render().el )

    @