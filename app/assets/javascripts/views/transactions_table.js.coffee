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

  showContent: ->
    @showChildView 'body', new FamilyBudget.Views.TransactionsTableBody
      collection: @collection
    @showChildView 'dropdown', new FamilyBudget.Views.Dropdown
      placeholder: 'date'
      items: ['date', 'amount', 'title', 'kind']

  onRender: ->
    @showContent()

  reverseCollection: ->
    @collection.models = @collection.models.reverse()
    @showContent()

  sortCollection: ->
    sortBy = @ui.selectSort.val()
    @collection.sortKey = sortBy
    @collection.sort()
    @showContent()
