FamilyBudget.Views.TransactionsTable = Marionette.View.extend

  template: JST['transactions_table']

  regions:
    'dropdownSort': '#js-region-sort'
    'dropdownType': '#js-region-type'
    body: 
      el: 'tbody'
      replaceElement: true

  ui:
    'btnReverse': '.js-reverse-btn'
    'selectSort': 'select[name="sortby"]'
    'table': '.table-transactions'

  events:
    'click @ui.btnReverse': 'reverseCollection'
    'change @ui.selectSort': 'sortCollection'

  initialize: (ops) ->
    @collection = ops.collection
    @listenTo FamilyBudget.Channels.transactionsTable, 'dropdown:sort:selected', @sortCollection
    @listenTo FamilyBudget.Channels.transactionsTable, 'dropdown:type:selected', @hideByType

  showTable: (collection )->
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

  onRender: ->
    @showTable @collection
    @showControls()

  reverseCollection: ->
    @collection.models = @collection.models.reverse()
    @showTable @collection

  sortCollection: (key) ->
    @collection.sortKey = key
    @collection.sort()
    @showTable @collection

  hideByType: (type) ->
    if type == 'all'
      @ui.table.find('.table-wrapper-cell').removeClass 'is-hidden'
    else 
      @ui.table.find('.table-wrapper-cell').addClass 'is-hidden'
      @ui.table.find('.table-wrapper-cell[data-type="' + type +  '"]').removeClass 'is-hidden'