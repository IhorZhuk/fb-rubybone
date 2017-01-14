class FamilyBudget.Views.TransactionsFormAdd extends FamilyBudget.Views.TransactionsFormBase

  initialize: (ops) ->
    super
    @collection = ops.collection
    
  onRender: ->
    super
    @ui.date.val FamilyBudget.Utilities.Dates.getToday()

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
      success: =>
        @resetInputs()
        @triggerMethod 'form:submited'
      error: =>
        @collection.trigger 'error'
        @collection.remove(@model,
          changes: ''
        )
      silent: true
      changes: ''
    )
    
  submit: (e) ->
    e.preventDefault()
    @createModel()
    @startListen()
    @resetInvalidInputs()
    if @model.isValid() then @save() else @renderErrors()