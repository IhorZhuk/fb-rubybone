# NOTICE: here are three views
# - base
# - add form
# - edit form

FamilyBudget.Views.TransactionsFormBase = Marionette.View.extend

  template: JST['transactions_form']

  ui:
    'date': 'input[name="date"]'
    'title': 'input[name="title"]'
    'amount': 'input[name="amount"]'
    'note': 'textarea[name="note"]'
    'error': '.js-error'

  events: 
    'submit': 'submit'

  startListen: ->
    @listenTo @model, 'invalid:title', @showErrorTitle
    @listenTo @model, 'invalid:amount', @showErrorAmount
    @listenTo @model, 'invalid:amount:title', @showErrorBoth

  resetInputs: ->
    @hideErrors()
    @ui.title.val ''
    @ui.amount.val ''
    @ui.note.val ''

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


# Add form
FamilyBudget.Views.TransactionsFormAdd = FamilyBudget.Views.TransactionsFormBase.extend

  initialize: ->
    @collection = FamilyBudget.app.transactions

  createModel: ->
    @model = new FamilyBudget.Models.Transaction
      date: @ui.date.val()
      title: @ui.title.val()
      amount: @ui.amount.val()
      note: @ui.note.val()
      kind: @$el.find('input[name="kind"]:checked').val()
    
  save: ->
    @collection.create(@model,
      changes: 'ch'
    )
    @resetInputs()
    @triggerMethod 'model:saved'
  
  submit: (e) ->
    e.preventDefault()
    @createModel()
    @startListen()
    @hideErrors()
    if @model.isValid() then @save() else @showError()


# Edit form
FamilyBudget.Views.TransactionsEdit = FamilyBudget.Views.TransactionsFormBase.extend

  className: 'form-modal'

  onRender: ->
    @fillInputs()
    @startListen()

  fillInputs: ->
    @ui.date.val @model.get('date')
    @ui.title.val @model.get('title')
    @ui.amount.val  @model.get('amount')
    @ui.note.val @model.get('note')

    kind = @model.get('kind')
    @$el.find('input[name="kind"][value="'+ kind + '"]').prop('checked', true)

  setNewValues: ->
    @model.set
      date: @ui.date.val()
      title: @ui.title.val()
      amount: @ui.amount.val()
      note: @ui.note.val()
      kind: @$el.find('input[name="kind"]:checked').val()

  save: ->
    that = @
    @model.save(
      null,
      success: (e) ->
        that.triggerMethod 'modal:close'
      error: ->
        alert 'Error in updating'
    )

  submit: (e) ->
    e.preventDefault()
    @submitForm()

  submitForm: ->
    @setNewValues()
    if @model.isValid() then @save() else @showError()

  submitModal: ->
    @submitForm()
