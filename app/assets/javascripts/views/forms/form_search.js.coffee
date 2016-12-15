FamilyBudget.Views.TransactionsFormSearch = Marionette.View.extend
  
  template: JST['transactions_form_search']

  ui:
    'title' : 'input[name="title"]'
    'amount' : 'input[name="amount"]'
    'kind' : 'input[name="kind"]'
    'categories' : 'select[name="category"]'
    'dateFrom' : 'input[name="date_from"]'
    'dateTo' : 'input[name="date_to"]'
    'note' : 'input[name="note"]'

  events:
    'submit' : 'submit'

  initialize: (ops) ->
    @collection = ops.collection

  onRender: ->
    @renderCategories()

  renderCategories: ->
    categories = new FamilyBudget.Collections.Categories()
    categories.fetch
      success: ( categories ) =>
       categories.each ((model) ->
        model = model.toJSON()
        @ui.categories.prepend "<option value=\"#{model.id}\">#{model.title}</option>"
      ), this

  setQuery: ->
    @query = {}

    @query.title = @ui.title.val() if @ui.title.val() != ''
    @query.amount = @ui.amount.val() if @ui.amount.val() != ''
    @query.kind = @ui.kind.val() if @ui.kind.val() != ''
    @query.category_id = @ui.categories.val() if @ui.categories.val() != ''
    @query.note = @ui.note.val() if @ui.note.val() != ''
    @query.date_from = @ui.dateFrom.val() if @ui.dateFrom.val() != ''
    @query.date_to = @ui.dateTo.val() if @ui.dateTo.val() != ''

  submit: (e) ->
    e.preventDefault()
    @setQuery()
    @collection.fetch
      success: (collection) =>
        if collection.length > 0
          console.log collection
        else
          console.log 'empty'

      error: (e) ->
        console.log e

      data: @query