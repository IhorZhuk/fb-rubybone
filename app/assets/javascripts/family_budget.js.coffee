window.FamilyBudget = 
  Models: {}
  Collections: {}
  Views: 
    Layout: {}
  Routers: {}
  Channels: {}
  Utilities: {}
    



FamilyBudget.App =  Marionette.Application.extend

  initialize: ->
    FamilyBudget.Channels.transactionsTable = Backbone.Radio.channel 'transctions_table'

  onBeforeStart: ->
    FamilyBudget.user = new UserAuth.Models.User()

    router = new FamilyBudget.Routers.Main()
    rootLayout = new FamilyBudget.Views.Layout.Root({router: router})
    rootLayout.render()
    

  onStart: ->
    Backbone.history.start() unless Backbone.History.started
    $(document).on 'click', 'a[href^="#"]', (event) ->
      event.preventDefault()
      url =  @getAttribute('href').replace('#','')
      Backbone.history.navigate(url, { trigger: true})