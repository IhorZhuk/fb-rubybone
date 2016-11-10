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
    modal = new FamilyBudget.Views.ModalForm({ title: 'Delete Confimration'})
    form = new FamilyBudget.Views.TransactionsDeleteConfirm({ model: @model, row: row})
    Backbone.trigger 'modal:open'
    $('.js-modal-content').html form.el
    

  edit: ->
    modal = new FamilyBudget.Views.ModalForm({ title: 'Edit Transaction'})
    form = new FamilyBudget.Views.TransactionsEdit({ model: @model})
    Backbone.trigger 'modal:open'
    $('.js-modal-content').html form.el