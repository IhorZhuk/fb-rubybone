FamilyBudget.Views.Layout.UserSettings = Marionette.View.extend

  template: JST['layouts/user_settings']

  regions:
     'userSettings': '#js-region-user-settings'
     'currency': '#js-region-currency'

  onRender: ->
    @showChildView 'userSettings', new FamilyBudget.Views.UserSettings()
    @showChildView 'currency', new FamilyBudget.Views.CurrencyForm()