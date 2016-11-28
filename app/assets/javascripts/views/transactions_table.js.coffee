FamilyBudget.Views.TransactionsTable = Marionette.View.extend

  template: JST['transactions_table']

  regions:
    'dropdown': '#js-region-sort'
    body: 
      el: 'tbody'
      replaceElement: true

  ui:
    'btnReverse': '.js-reverse-btn'
    'selectSort': 'select[name="sortby"]'

  events:
    'click @ui.btnReverse': 'reverseCollection'
    'change @ui.selectSort': 'sortCollection'

  initialize: (ops) ->
    @collection = ops.collection
    @listenTo FamilyBudget.Channels.transactionsTable, 'dropdown:selected', @sortCollection

  showTable: ->
    @showChildView 'body', new FamilyBudget.Views.TransactionsTableBody
      collection: @collection

  showControls: ->
    @showChildView 'dropdown', new FamilyBudget.Views.Dropdown
      placeholder: 'date'
      items: ['date', 'amount', 'title', 'kind']
      channel: FamilyBudget.Channels.transactionsTable
      channelEvent: 'dropdown:selected'


  onRender: ->
    @showTable()
    @showControls()

  reverseCollection: ->
    @collection.models = @collection.models.reverse()
    @showTable()

  sortCollection: (key) ->
    @collection.sortKey = key
    @collection.sort()
    @showTable()
