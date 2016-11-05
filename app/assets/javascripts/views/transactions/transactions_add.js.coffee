class FamilyBudget.Views.TransactionsAdd extends Backbone.View

  template: JST['transactions/add']

  el: '.js-page-add-left-col'

  events: 
    'submit .js-add-transaction-form': 'submit'
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

    