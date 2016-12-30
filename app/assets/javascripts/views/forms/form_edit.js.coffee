class FamilyBudget.Views.TransactionsEdit extends FamilyBudget.Views.TransactionsFormBase

  className: 'form-modal'

  onRender: ->
    super()
    @fillInputs()
    @startListen()

  fillInputs: ->
    @ui.date.val @model.get('date')
    @ui.title.val @model.get('title')
    @ui.amount.val  @model.get('amount')
    @ui.note.val @model.get('note')

    kind = @model.get('kind')
    @$el.find('input[name="kind"][value="'+ kind + '"]').prop('checked', true)

  setNewValues: ->
    @model.set
      date: @ui.date.val()
      title: @ui.title.val()
      amount: @ui.amount.val()
      note: @ui.note.val()
      kind: @$el.find('input[name="kind"]:checked').val()
      category_id: @ui.categories.val()

  save: ->
    @model.save(
      null,
      success: (e) =>
        @triggerMethod 'modal:close'
        FamilyBudget.Channels.transactionsTable.trigger 'transaction:edited'
      error: =>
        alert 'Error in updating'
    )

  submit: (e) ->
    e.preventDefault()
    @submitForm()

  submitForm: ->
    @setNewValues()
    if @model.isValid() then @save() else @renderErrors()

  submitModal: ->
    @submitForm()
