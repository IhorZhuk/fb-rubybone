FamilyBudget.Views.TransactionsTable = Marionette.View.extend

  template: JST['transactions_table']

  regions:
    'dropdownSort': '#js-region-sort'
    'dropdownType': '#js-region-type'
    'pagination': '#js-region-pagination'
    body: 
      el: '.js-tbody'
      replaceElement: true

  ui:
    'btnReverse': '.js-reverse-btn'
    'selectSort': 'select[name="sortby"]'
    'table': '.table-transactions'

  events:
    'click @ui.btnReverse': 'reverseCollection'
    'change @ui.selectSort': 'sortCollection'

  childViewEvents: 
    'pagination:clicked': 'nextPage'

  initialize: (ops) ->
    @collection = ops.collection
    @listenTo FamilyBudget.Channels.transactionsTable, 'dropdown:sort:selected', @sortCollection
    @listenTo FamilyBudget.Channels.transactionsTable, 'dropdown:type:selected', @hideByType
    

  nextPage: (page) ->
    @collection = new FamilyBudget.Collections.Transactions()
    @listenTo @collection, 'reset', @renderTable
    @collection.fetch
      error: (e) ->
        console.log e
      reset: true
      data: 
        page: page

  renderTable: ->
    @showTable @collection
    @showControls()
    @showPagination()

  showTable: (collection) ->
    @showChildView 'body', new FamilyBudget.Views.TransactionsTableBody
      collection: collection

  showControls: ->
    @showChildView 'dropdownSort', new FamilyBudget.Views.Dropdown
      placeholder: 'date'
      items: ['date', 'amount', 'title']
      channel: FamilyBudget.Channels.transactionsTable
      channelEvent: 'dropdown:sort:selected'

    @showChildView 'dropdownType', new FamilyBudget.Views.Dropdown
      placeholder: 'all'
      items: ['all', 'credit', 'debit']
      channel: FamilyBudget.Channels.transactionsTable
      channelEvent: 'dropdown:type:selected'

  showPagination: ->
    @showChildView 'pagination', new FamilyBudget.Views.TransactionsPagination
      collection: @collection

  onRender: ->
    @renderTable()

  reverseCollection: ->
    @collection.models = @collection.models.reverse()
    @showTable @collection

  sortCollection: (key) ->
    @collection.sortKey = key
    @collection.sort()
    @showTable @collection

  hideByType: (type) ->
    if type == 'all'
      @ui.table.removeClass 'show-credit show-debit'
    else
      @ui.table.addClass('show-' + type)