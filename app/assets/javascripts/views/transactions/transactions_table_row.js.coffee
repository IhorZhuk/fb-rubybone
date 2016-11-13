class FamilyBudget.Views.TransactionsTableRow extends Backbone.Marionette.ItemView

  template: JST['transactions/row']

  tagName: 'tr'

  events: 
    'click .js-delete-transaction': 'destroy'
    'click .js-edit-transaction': 'edit'
    'click .js-show-note': 'toggleNote'

  ui:
    note: '.table-row-note'
    noteTrigger: '.js-show-note'

  initialize: ->
    @render()

  render: ->
    @$el.html( @template(@model.toJSON()) )
    @
      

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