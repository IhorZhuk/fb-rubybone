FamilyBudget.Views.TransactionsFilter = Marionette.View.extend 

  template: JST['transactions/transactions_filter']

  ui: 
   'title': 'input[name="title"]'

  regions:
    'period': '#js-region-period'
    'order': '#js-region-order'
    'type': '#js-region-type'
    'direction': '#js-region-direction'
    'category': '#js-region-category'

  childViewEvents: 
    'dropdown:updated': 'updateFilters'

  events:
    'change input': 'updateFilters'

  initialize: (ops) ->
    @query = ops.query
    @categories = []

  onRender: ->
    @showChildView 'period', new FamilyBudget.Views.DropdownDates()
    @renderCategories()

    @showChildView 'type', new FamilyBudget.Views.Dropdown
      inputName: 'kind'
      placeholder: @query.kind || 'any'
      items: ['any', 'credit', 'debit']

    @showChildView 'order', new FamilyBudget.Views.Dropdown
      inputName: 'order'
      placeholder: 'Date'
      items: ['date', 'title', 'amount']

    @showChildView 'direction', new FamilyBudget.Views.Dropdown
      inputName: 'direction'
      placeholder: 'DESC'
      items: ['DESC', 'ASC']

  updateFilters: ->
    @getCurrentState()
    FamilyBudget.Channels.transactionsTable.trigger 'filter:clicked', @filters

  getCurrentState: ->
    kind = @$el.find('input[name="kind"]').val()
    if kind == 'any'
      kind = ''
    else
      kind = kind

    @filters = 
      date_from: @$el.find('input[name="date_from"]').val()
      date_to: @$el.find('input[name="date_to"]').val()
      order: @$el.find('input[name="order"]').val()
      kind: kind
      direction: @$el.find('input[name="direction"]').val()
      title: @ui.title.val()
      category_id: @$el.find('input[name="category_id"]').val()

  renderCategories: ->
    collection = new FamilyBudget.Collections.Categories()
    collection.fetch
      success: ( collection) =>
        collection.each ((model) ->
          model = model.toJSON()
          @categories.push { value:model.id, title: model.title }
        ), this
        @categories.unshift { value:'', title: 'Any'}

        @showChildView 'category', new FamilyBudget.Views.Dropdown
          inputName: 'category_id'
          placeholder: 'Any'
          items: @categories
          customVals: true