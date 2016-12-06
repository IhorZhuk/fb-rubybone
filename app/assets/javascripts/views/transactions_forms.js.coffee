# NOTICE: here are three views
# - base
# - add form
# - edit form

class FamilyBudget.Views.TransactionsFormBase extends Marionette.View

  template: JST['transactions_form']

  ui:
    'date': 'input[name="date"]'
    'title': 'input[name="title"]'
    'amount': 'input[name="amount"]'
    'note': 'textarea[name="note"]'
    'error': '.js-error'
    'categories': '.js-categories'

  events: 
    'submit': 'submit'

  onRender: ->
    @renderCategories()

  startListen: ->
    @listenTo @model, 'invalid', @renderErrors
    @listenTo @model, 'error', @parseErrorResponse

  resetInputs: ->
    @hideErrors()
    @ui.title.val ''
    @ui.amount.val ''
    @ui.note.val ''

  renderErrors: (model, errors) ->
    _.each errors, @renderError, @

  renderError:(errors, attribute) ->
    error = errors.join '; '
    @$el.find('input[name=' + attribute + ']').addClass 'is-invalid'
    @ui.error.prepend('<span>' + attribute + ' ' + error + ';</span>').show()

  parseErrorResponse: (model, resp) ->
    if resp and resp.responseText
      errors = JSON.parse resp.responseText
      @renderErrors(model, errors.errors)

  hideErrors: ->
    @ui.title.removeClass 'is-invalid'
    @ui.amount.removeClass 'is-invalid'
    @ui.error.html('').hide()

  renderCategories: ->
    collection = new FamilyBudget.Collections.Categories()
    collection.fetch
      success: ( collection) =>
       collection.each ((model) ->
        model = model.toJSON()
        @ui.categories.prepend "<option value=\"#{model.id}\">#{model.title}</option>"
        if @model?
          category =  @model.get('category_id')
          @ui.categories.find('option[value="' + category + '"]').attr('selected','selected')
      ), this

# ===================
# Add form
class FamilyBudget.Views.TransactionsFormAdd extends FamilyBudget.Views.TransactionsFormBase

  initialize: ->
    @collection = FamilyBudget.app.transactions

  createModel: ->
    @model = new FamilyBudget.Models.Transaction
      date: @ui.date.val()
      title: @ui.title.val()
      amount: @ui.amount.val()
      note: @ui.note.val()
      kind: @$el.find('input[name="kind"]:checked').val()
      category_id: @ui.categories.val()
    
  save: ->
    @collection.create(@model,
      changes: ''
    )
    @resetInputs()
    @triggerMethod 'model:saved'
  
  submit: (e) ->
    e.preventDefault()
    @createModel()
    @startListen()
    @hideErrors()
    if @model.isValid() then @save() else @renderErrors()



# ===================
# Edit form
class FamilyBudget.Views.TransactionsEdit extends FamilyBudget.Views.TransactionsFormBase

  className: 'form-modal'

  onRender: ->
    super()
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
      category_id: @ui.categories.val()

  save: ->
    @model.save(
      null,
      success: (e) =>
        @triggerMethod 'modal:close'
      error: =>
        alert 'Error in updating'
    )

  submit: (e) ->
    e.preventDefault()
    @submitForm()

  submitForm: ->
    @setNewValues()
    if @model.isValid() then @save() else @renderErrors()

  submitModal: ->
    @submitForm()
