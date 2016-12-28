FamilyBudget.Views.Layout.UserSettings = Marionette.View.extend

  template: JST['layouts/user_settings']

  regions:
     'content': '#js-region-content'

  onRender: ->
    @showChildView 'content', new FamilyBudget.Views.UserSettings()