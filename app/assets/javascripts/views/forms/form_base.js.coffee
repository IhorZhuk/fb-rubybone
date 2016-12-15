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