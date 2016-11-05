class FamilyBudget.Views.TransactionsAdd extends Backbone.View

  template: JST['transactions/add']

  el: '.js-page-add-left-col'

  events: 
    'submit .js-add-transaction-form': 'addForm'
    'focusout input': 'resetInputs'

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
      title: @$el.find('input[name="title"]')
      amount: @$el.find('input[name="amount"]')
      date: @$el.find('input[name="date"]')
      note: @$el.find('textarea[name="note"]')
      
  buildTransaction: ->
    @transaction = new FamilyBudget.Models.Transaction(
      kind: @$el.find('input[name="kind"]:checked').val()
      title: @ui.title.val()
      amount: @ui.amount.val()
      date: @ui.date.val()
      note: @ui.note.val()
    )
      
  addForm: (e) ->
    e.preventDefault()
    that = @
    @buildTransaction()
    if @transaction.isValid()
      @collection.create(@transaction,
        success: (res) ->
          Backbone.trigger "transactionAdded"
          that.resetInputs()
      )

  resetInputs: ->
    if @ui.title.val() != ''
      @ui.title.removeClass('is-invalid').attr('placeholder', 'Title')

    if @ui.amount.val() != ''
      @ui.amount.removeClass('is-invalid').attr('placeholder', 'Amount')
    
  showErrorTitle: ->
    @ui.title.addClass('is-invalid').attr('placeholder', 'Title can\'t be blank')

  showErrorAmount: ->
    @ui.amount.addClass('is-invalid').attr('placeholder', 'Amount can\'t be blank')

  showErrors: ->
    @showErrorTitle()
    @showErrorAmount()

    