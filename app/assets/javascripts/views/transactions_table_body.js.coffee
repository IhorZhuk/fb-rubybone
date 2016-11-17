FamilyBudget.Views.TransactionsTableBody = Marionette.CollectionView.extend

  tagName: 'tbody'

  initialize: ->
    @childView = FamilyBudget.Views.TransactionsTableRow