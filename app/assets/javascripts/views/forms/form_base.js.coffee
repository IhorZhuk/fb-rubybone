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

  initialize: ->
    Cocktail.mixin @, FamilyBudget.Utilities.ValidationHandler

  onRender: ->
    @renderCategories()

  startListen: ->
    @listenTo @model, 'invalid', @renderErrors
    @listenTo @model, 'error', @parseErrorResponse
  
  resetInputs: ->
    @ui.title.val ''
    @ui.amount.val ''
    @ui.note.val ''
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