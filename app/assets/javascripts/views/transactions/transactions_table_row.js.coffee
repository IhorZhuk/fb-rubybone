class FamilyBudget.Views.TransactionsTableRow extends Backbone.View

  template: JST['transactions/row']

  tagName: 'tr'

  events: 
    'click .js-delete-transaction': 'destroy'
    'click .js-edit-transaction': 'edit'
    'click .js-show-note': 'toggleNote'

  initialize: ->
    @render()

  render: ->
    @$el.html( @template(@model.toJSON()) )
    @setUI()
    @

  setUI: ->
    @ui = 
      note: @$el.find('.table-row-note')
      noteTrigger: @$el.find('.js-show-note')

  toggleNote: ->
    @ui.note.toggle()

  destroy: ->
    row = @$el
    @model.destroy success: () ->
      row.remove()