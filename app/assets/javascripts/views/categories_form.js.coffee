FamilyBudget.Views.CategoryForm = Marionette.View.extend

  template: JST['category_form']

  ui:
    'title': 'input[name="title"]'
    'error': '.js-error'

  events:
    'submit': 'submit'

  initialize: (ops) ->
    @collection = ops.collection

  createModel: ->
    @model = new FamilyBudget.Models.Category
      title: @ui.title.val()

  resetForm: ->
    @ui.title.val ''
    @ui.title.removeClass 'is-invalid'
    @ui.error.hide()

  save: ->
    @collection.create(@model,
      changes: ''
    )
    @resetForm()

  showError: ->
    @ui.title.addClass 'is-invalid'
    @ui.error.text(@model.validationError).show()
    
  submit:(e) ->
    e.preventDefault()
    @createModel()
    if @model.isValid() then @save() else @showError()
