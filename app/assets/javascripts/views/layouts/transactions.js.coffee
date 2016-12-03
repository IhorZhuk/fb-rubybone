FamilyBudget.Views.Layout.Transactions = Marionette.View.extend

  template: JST['layouts/transactions']

  regions:
    'content': '#js-region-page-content'
    'dropdown': '#js-region-dropdown'

  initialize: ->
    @collection = new FamilyBudget.Collections.Transactions()
    @date = FamilyBudget.Channels.transactionsPeriods.request 'thisMonth'
    @listenTo FamilyBudget.Channels.transactionsLayout, 'dropdown:period', @updateTable
    @listenTo @collection, 'update', @renderTable    

  onRender: ->
    @renderControls()
    @renderTable()
    
  renderTable: ->
    @collection.fetch
      success: (collection) =>
        if collection.length > 0
          @showChildView 'content', new FamilyBudget.Views.TransactionsTable
            collection: collection
        else
          @showChildView 'content', new FamilyBudget.Views.TransactionsEmpty()
      data:
        date_from: @date.from
        date_to: @date.to
      #WHAT IS IT?
      changes: ''

  renderControls: ->
    @showChildView 'dropdown', new FamilyBudget.Views.Dropdown
      inputName: 'transactions_period'
      placeholder: 'this month'
      items: ['this month', 'this week', 'last week', 'last month']
      channel: FamilyBudget.Channels.transactionsLayout
      channelEvent: 'dropdown:period'

  updateTable: (period) ->
    period = period.toLowerCase()

    switch period
      when 'this week'
        @date = FamilyBudget.Channels.transactionsPeriods.request('thisWeek')
      when 'this month'
        @date = FamilyBudget.Channels.transactionsPeriods.request('thisMonth')
      when 'last month'
        @date = FamilyBudget.Channels.transactionsPeriods.request('lastMonth')
      when 'last week'
        @date = FamilyBudget.Channels.transactionsPeriods.request('lastWeek')

    @renderTable()