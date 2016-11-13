# her are base form, add and edit forms

class FamilyBudget.Views.TransactionsForm extends Backbone.View

  template: JST['transactions/add']

  events: 
    'keyup input[name="title"]': 'resetInputsDebounce'
    'keyup input[name="amount"]': 'resetInputsDebounce'

  initialize: ->
    @render()
    @listenTo Backbone, 'amount:title:invalid', @showErrors
    @listenTo Backbone, 'amount:invalid', @showErrorAmount
    @listenTo Backbone, 'title:invalid', @showErrorTitle

  render: ->
    @$el.html( @template() )
    @setUI()
    @

  setUI: ->
    @ui = 
      title: @$el.find 'input[name="title"]'
      titleError: @$el.find 'input[name="title"] + .form-error'
      amount: @$el.find 'input[name="amount"]'
      amountError: @$el.find 'input[name="amount"] + .form-error'
      date: @$el.find 'input[name="date"]'
      note: @$el.find 'textarea[name="note"]'
      errors: @$el.find '.form-error'
      
  resetInputsDebounce: _.debounce (->
    @resetInputs()
  ), 250
      
  resetInputs: ->
    if @ui.title.val() != ''
      @ui.title.removeClass 'is-invalid' 
      @ui.titleError.removeClass 'is-active' 

    if @ui.amount.val() != ''
      @ui.amount.removeClass 'is-invalid' 
      @ui.amountError.removeClass 'is-active' 
    
  showErrorTitle: ->
    @ui.title.addClass 'is-invalid'
    @ui.titleError.addClass('is-active').text 'Title can\'t be blank'

  showErrorAmount: ->
    @ui.amount.addClass 'is-invalid'
    @ui.amountError.addClass('is-active').text 'Amount can\'t be blank, has negative value or be equal zero'

  showErrors: ->
    @showErrorTitle()
    @showErrorAmount()



#===============================================
# Add form
class FamilyBudget.Views.TransactionsAdd extends FamilyBudget.Views.TransactionsForm

  events: ->
     _.extend {}, FamilyBudget.Views.TransactionsForm::events, 'submit .js-add-transaction-form': 'submit'

    
  buildTransaction: ->
    @transaction = new FamilyBudget.Models.Transaction(
      kind: @$el.find('input[name="kind"]:checked').val()
      title: @ui.title.val()
      amount: @ui.amount.val()
      date: @ui.date.val()
      note: @ui.note.val()
    )

  submit: (e) ->
    e.preventDefault()
    that = @
    @buildTransaction()
    if @transaction.isValid()
      @collection.create(@transaction,
        success: (res) ->
          Backbone.trigger "transactionAdded"
          that.resetInputs()
      )


#===============================================
# Edit form
class FamilyBudget.Views.TransactionsEdit extends FamilyBudget.Views.TransactionsForm

  events: ->
     _.extend {}, FamilyBudget.Views.TransactionsForm::events, 'submit .js-add-transaction-form': 'submit'

  initialize: ->
    FamilyBudget.Views.TransactionsEdit.__super__.initialize.apply @
    @setValues()

  setValues: ->
    @ui.title.val @model.get('title')
    @ui.amount.val @model.get('amount')
    @ui.date.val @model.get('date')
    @ui.note.val @model.get('note')

    if @model.get('kind') == 'credit'
      @$el.find('input[name="kind"][value="credit"]').prop('checked', true)
    else
      @$el.find('input[name="kind"][value="debit"]').prop('checked', true)
    
    

  buildTransaction: ->
    @model.set({
      kind: @$el.find('input[name="kind"]:checked').val()
      title: @ui.title.val()
      amount: @ui.amount.val()
      date: @ui.date.val()
      note: @ui.note.val()
    })
      
 
  submit: (e) ->
    e.preventDefault()
    that = @
    @buildTransaction()
    if @model.isValid()
      @model.save(
        null,
        success: (e) ->
          console.log 'test'
          Backbone.trigger 'transactionAdded'
          Backbone.trigger 'modal:close'
      )