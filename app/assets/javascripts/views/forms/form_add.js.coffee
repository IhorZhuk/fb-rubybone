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