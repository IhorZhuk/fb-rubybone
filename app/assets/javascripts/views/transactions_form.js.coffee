FamilyBudget.Views.TransactionsForm = Marionette.View.extend

  template: JST['transactions_form']

  ui:
    'date': 'input[name="date"]'
    'title': 'input[name="title"]'
    'amount': 'input[name="amount"]'
    'note': 'textarea[name="note"]'
    'error': '.js-error'

  events: 
    'submit': 'submit'

  initialize: ->
    @collection = FamilyBudget.app.transactions

  createModel: ->
    @model = new FamilyBudget.Models.Transaction
      date: @ui.date.val()
      title: @ui.title.val()
      amount: @ui.amount.val()
      note: @ui.note.val()
      kind: @$el.find('input[name="kind"]:checked').val()
    
  startListen: ->
    @listenTo @model, 'invalid:title', @showErrorTitle
    @listenTo @model, 'invalid:amount', @showErrorAmount
    @listenTo @model, 'invalid:amount:title', @showErrorBoth

  save: ->

    @collection.create(@model,
      success: (res) ->
        console.log 'added'
      changes: 'ch'
    )

  showError: ->
    @ui.error.text(@model.validationError).show()

  showErrorTitle: ->
    @ui.title.addClass 'is-invalid'

  showErrorAmount: ->
    @ui.amount.addClass 'is-invalid'

  showErrorBoth: ->
    @showErrorTitle()
    @showErrorAmount()

  hideErrors: ->
    @ui.title.removeClass 'is-invalid'
    @ui.amount.removeClass 'is-invalid'
    @ui.error.hide()
  
  submit: (e) ->
    e.preventDefault()
    @createModel()
    @startListen()
    @hideErrors()
    if @model.isValid() then @save() else @showError()