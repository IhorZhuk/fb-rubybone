class FamilyBudget.Views.TransactionsTable extends Backbone.View

  template: JST['transactions/table']

  el: '.js-page-add-right-col'

  events: {
    'click th' : 'sort'
  }

  initialize: ->
    _.bindAll this, 'render'
    @collection.fetch({success: @render})
    @listenTo Backbone, 'transactionAdded', @render
    

  render: ->
    @$el.html( @template() )
    @setUI()
    @renderRows()
    

  renderRows: ->
    that = @
    @ui.tbody.html('')
    @collection.each (model) ->
      row = new FamilyBudget.Views.TransactionsTableRow({ model: model})
      that.ui.tbody.prepend( row.render().el )
    @

  setUI: ->
    @ui = 
      tbody: @$el.find('tbody')
      th: @$el.find('thead th')
  
  sort: (e) ->
    target = $(e.target)

    if target.hasClass 'sort-asc'
      @ui.th.removeClass 'sort-asc sort-desc'
      target.addClass 'sort-desc'
      order = 'desc'
    else if target.hasClass 'sort-desc'
      @ui.th.removeClass 'sort-asc sort-desc'
      target.addClass 'sort-asc'
      order = 'asc'
    else 
      @ui.th.removeClass 'sort-asc sort-desc'
      target.addClass 'sort-asc'
      order = 'asc'
    
    @collection.sortKey = target.data 'model-attr'
    @collection.sort()
    if order == 'asc' then @collection.models.reverse()
    @renderRows()