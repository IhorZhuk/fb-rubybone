window.FamilyBudget = 
  Models: {}
  Collections: {}
  Views: 
    Layout: {}
  Routers: {}



App =  Marionette.Application.extend

  initialize: ->
    router = new FamilyBudget.Routers.Main()
    rootLayout = new FamilyBudget.Views.Layout.Root({router: router})
    $('body').html rootLayout.render().el
    

  onStart: ->
    Backbone.history.start()

  
$(document).ready ->
  FamilyBudget.app = new App()
  FamilyBudget.app.start()