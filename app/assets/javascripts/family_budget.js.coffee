window.FamilyBudget = 
  Models: {}
  Collections: {}
  Views: 
    Layout: {}
  Routers: {}
  Channels: {}
    



App =  Marionette.Application.extend

  initialize: ->
    router = new FamilyBudget.Routers.Main()
    rootLayout = new FamilyBudget.Views.Layout.Root({router: router})
    @transactions = new FamilyBudget.Collections.Transactions()
    rootLayout.render()
    

  onStart: ->
    Backbone.history.start()
    $(document).on 'click', 'a[href^="#"]', (event) ->
      event.preventDefault()
      url =  @getAttribute('href').replace('#','')
      Backbone.history.navigate(url, { trigger: true})
  
$(document).ready ->
  FamilyBudget.app = new App()
  FamilyBudget.app.start()