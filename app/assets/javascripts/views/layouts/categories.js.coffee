FamilyBudget.Views.Layout.Categories = Marionette.View.extend

  template: JST['layouts/categories']

  regions:
    'content': '#js-region-content'

  onRender: ->
    @showCategories()

  showCategories: ->
    @collection = new FamilyBudget.Collections.Categories()
    @collection.fetch
      success: ( collection) =>
        @showChildView 'content', new FamilyBudget.Views.CategoryForm
          collection: collection