window.FamilyBudget =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
    new FamilyBudget.Views.NavbarIndex()
    new FamilyBudget.Routers.Layout()
    Backbone.history.start()

    #make sure anchor links trigger routers
    $(document).on 'click', 'a[href^="#"]', (event) ->
      event.preventDefault()
      url =  @getAttribute('href').replace('#','')
      Backbone.history.navigate(url, { trigger: true})

$(document).ready ->
  FamilyBudget.initialize()
