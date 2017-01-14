FamilyBudget.Views.CategoriesTable = Marionette.CollectionView.extend

  tagName: 'table'

  className: 'table-main table-categories'

  initialize: ->
    @childView = FamilyBudget.Views.CategoriesTableRow