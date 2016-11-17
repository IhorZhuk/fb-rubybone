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


  toggleNote: ->
    @ui.note.toggleClass 'is-hidden'