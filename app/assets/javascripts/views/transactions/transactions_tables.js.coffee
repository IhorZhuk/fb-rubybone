# here are a few tables Base, Today, All

class FamilyBudget.Views.TransactionsTableBase extends Backbone.View

  template: JST['transactions/table']

  events: {
    'click th' : 'sort'
  }

  @order: 'desc'

  render: ->
    if @collection.length == 0
      @$el.html 'There aren\'t any transactions according to your search criteria'
    else
      @$el.html( @template() )
      @setUI()
      @renderRows()
    @

  renderRows: ->
    that = @
    @ui.tbody.html('')
    if @order == 'asc' then @collection.models.reverse()
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
      @order = 'desc'
    else if target.hasClass 'sort-desc'
      @ui.th.removeClass 'sort-asc sort-desc'
      target.addClass 'sort-asc'
      @order = 'asc'
    else 
      @ui.th.removeClass 'sort-asc sort-desc'
      target.addClass 'sort-asc'
      @order = 'asc'
    
    @collection.sortKey = target.data 'model-attr'
    @collection.sort()
    @renderRows()

# =============================================

class FamilyBudget.Views.TransactionsTableToday extends FamilyBudget.Views.TransactionsTableBase

  el: '.js-page-add-right-col'

  initialize: ->
    _.bindAll this, 'render'
    now = new Date()
    @collection.fetch({success: @render, data: { date: now }})
    @listenTo Backbone, 'transactionAdded', @render

# ===================================================

class FamilyBudget.Views.TransactionsTableAll extends FamilyBudget.Views.TransactionsTableBase

  el: '.js-page-transactions'

  initialize: ->
    _.bindAll this, 'render'
    @collection.fetch({success: @render})
    @listenTo Backbone, 'transactionAdded', @render
