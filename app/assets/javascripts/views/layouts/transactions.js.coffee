FamilyBudget.Views.Layout.Transactions = Marionette.View.extend

  template: JST['layouts/transactions']

  regions:
    'content': '#js-region-page-content'
    'dropdown': '#js-region-dropdown'

  initialize: ->
    @listenTo FamilyBudget.Channels.transactionsLayout, 'dropdown:period', @updateTable
    @collection = new FamilyBudget.Collections.Transactions()
    @listenTo @collection, 'update', @checkCollectionLength

  checkCollectionLength: ->
    console.log @collection.length

  onRender: ->
    @date = FamilyBudget.Channels.transactionsPeriods.request('thisMonth')
    @renderControls()
    @renderTable()
    
  renderTable: ->
    that = @
    @collection.fetch
      success: (collection) ->
        if collection.length > 0
          that.showChildView 'content', new FamilyBudget.Views.TransactionsTable
            collection: collection
        else
          that.showChildView 'table', new FamilyBudget.Views.TransactionsEmpty()
      data:
        date_from: that.date.from
        date_to: that.date.to

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