FamilyBudget.Views.Layout.Settings = Marionette.View.extend

  template: JST['layouts/settings']

  ui:
    'menu' : '.js-menu'
    'links': '.js-menu button'

  regions:
     'content': '#js-region-content'

  events:
    'click @ui.links': 'navigate'

  onRender: ->
    @showCategories()

  showCategories: ->
    @collection = new FamilyBudget.Collections.Categories()
    @collection.fetch
      success: ( collection) =>
        @showChildView 'content', new FamilyBudget.Views.CategoryForm
          collection: collection

  showUserSettings: ->
    @showChildView 'content', new FamilyBudget.Views.UserSettings()

  navigate: (e) ->
    e.preventDefault()
    target = $(e.target).closest 'button'
    @ui.links.removeClass 'is-active'
    target.addClass 'is-active'

    switch target.data('target')
      when 'categories' then @showCategories()
      when 'user' then @showUserSettings()