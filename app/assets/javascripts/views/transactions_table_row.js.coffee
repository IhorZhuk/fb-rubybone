FamilyBudget.Views.TransactionsTableRow = Marionette.View.extend

  tagName: 'tr'

  template: JST['transactions_table_row']

  ui:
    'btnDelete': '.js-delete'
    'btnEdit': '.js-edit'
    'btnNote': '.js-show-note'
    'note': '.table-row-note'

  events:
   'click @ui.btnNote': 'toggleNote'
   'click @ui.btnDelete': 'openDeleteModal'
   'click @ui.btnEdit' : 'openEditModal'

  initialize: ->
    @listenTo @model, 'remove', @removeView
    @listenTo @model, 'change', @render


  toggleNote: ->
    @ui.note.toggleClass 'is-hidden'

  openDeleteModal: ->
    modal = new FamilyBudget.Views.Modal
      title: 'Delete Confirmation'
      content: new FamilyBudget.Views.ConfirmDelete
        model: @model
        template: JST['confirm_delete_transaction']

  openEditModal: ->
    modal = new FamilyBudget.Views.Modal
      title: 'Edit transaction'
      content: new FamilyBudget.Views.TransactionsEdit
        model: @model
  
  removeView: ->
    @$el.addClass 'table-row-delete'
    @$el.fadeOut()