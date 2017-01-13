FamilyBudget.Views.CurrencyForm = Marionette.View.extend

  template: JST['currency_form']

  ui:
    'title':'input[name="title"]'
    'error': '.js-error'
    'success': '.js-success'

  events: 
    'submit form':'submit'

  initialize: ->
    Cocktail.mixin @, FamilyBudget.Utilities.ValidationHandler
    @model = new FamilyBudget.Models.Currency()
    @listenTo @model, 'sync', @fillInput
    @listenTo @model, 'error', @parseErrorResponse
    @listenTo @model, 'invalid', @renderErrors
    
  onRender:->
    @model.fetch()

  fillInput: (model) ->
    @ui.title.val(model.toJSON().title)

  renderMessage: ->
    @ui.success.text('Saved').show()

  submit: (e) ->
    e.preventDefault()
    @ui.success.hide().text ''
    @resetInvalidInputs()
    @model.set
      title: @ui.title.val()
    @model.save null, success: (model, res) =>
        @renderMessage()