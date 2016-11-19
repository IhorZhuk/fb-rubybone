FamilyBudget.Views.Layout.Add = Marionette.View.extend

  template: JST['layouts/add']

  regions:
    'form': '#js-region-form'
    'table': '#js-region-table'

  onRender: ->
    @showChildView 'table', new FamilyBudget.Views.TransactionsTable()
    @showChildView 'form', new FamilyBudget.Views.TransactionsForm()