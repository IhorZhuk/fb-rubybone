class FamilyBudget.Views.TransactionsAdd extends Backbone.View

  template: JST['transactions/add']

  el: '.js-page-add-left-col'

  events: 
    'submit .js-add-transaction-form': 'addForm'
  initialize: ->
    @render()

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
    @buildTransaction()
    @collection.create(@transaction,
      success: (res) ->
        Backbone.trigger "transactionAdded"
        console.log res
    )
    
    