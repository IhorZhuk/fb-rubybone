window.FamilyBudget =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
    new FamilyBudget.Views.NavbarIndex()
    new FamilyBudget.Routers.Layout
    Backbone.history.start()

$(document).ready ->
  FamilyBudget.initialize()
