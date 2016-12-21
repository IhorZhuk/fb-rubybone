FamilyBudget.Views.TransactionsFilter = Marionette.View.extend 

  template: JST['transactions_filter']

  ui: 
   'title': 'input[name="title"]'

  regions:
    'period': '#js-region-period'
    'order': '#js-region-order'
    'type': '#js-region-type'
    'direction': '#js-region-direction'

  childViewEvents: 
    'dropdown:updated': 'updateFilters'

  events:
    'change input': 'updateFilters'

  onRender: ->
    @showChildView 'period', new FamilyBudget.Views.DropdownDates()

    @showChildView 'type', new FamilyBudget.Views.Dropdown
      inputName: 'kind'
      placeholder: 'any'
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