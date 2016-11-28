FamilyBudget.Views.Layout.Transactions = Marionette.View.extend

  template: JST['layouts/transactions']

  regions:
    'content': '#js-region-page-content'
    'dropdown': '#js-region-dropdown'

  initialize: ->
    @listenTo FamilyBudget.Channels.transactionsLayout, 'dropdown:period', @updateTable

  onBeforeRender: ->
    @collection = new FamilyBudget.Collections.Transactions()

  getCurrentMonth: ->
    now = new Date()
    @date =
      from: new Date(now.getFullYear(), now.getMonth(), 1)
      to: new Date(now.getFullYear(), now.getMonth() + 1, 0)

  getCurrentWeek: ->
    now = new Date()
    @date = 
      from: new Date(now.setDate(now.getDate() - now.getDay()))
      to: new Date(now.setDate(now.getDate() - now.getDay()+6));

  getLastWeek: ->
    now = new Date()
    @date = 
      from: new Date(now.setDate(now.getDate() - now.getDay() - 7))
      to: new Date(now.setDate(now.getDate() - now.getDay() - 1));

  getLastMonth: ->
    now = new Date()
    @date = 
      from: new Date(now.getFullYear(), now.getMonth() - 1, 1)
      to: new Date(now.getFullYear(), now.getMonth(), 0)

  onRender: ->
    @getCurrentMonth()
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
        @getCurrentWeek()
      when 'this month'
        @getCurrentMonth()
      when 'last month'
        @getLastMonth()
      when 'last week'
        @getLastWeek()

    @renderTable()