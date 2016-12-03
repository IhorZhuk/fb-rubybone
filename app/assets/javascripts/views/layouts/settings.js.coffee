FamilyBudget.Views.Layout.Settings = Marionette.View.extend

  template: JST['layouts/settings']

  regions:
     'categories' : '#js-region-categories'
     'addCategory': '#js-region-add-category'

  onRender: ->
    @collection = new FamilyBudget.Collections.Categories()
    @collection.fetch
      success: ( collection) =>
        @showChildView 'categories', new FamilyBudget.Views.CategoriesTable
          collection: collection
        @showChildView 'addCategory', new FamilyBudget.Views.CategoryForm
          collection: collection