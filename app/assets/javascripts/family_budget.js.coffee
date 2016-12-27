window.FamilyBudget = 
  Models: {}
  Collections: {}
  Views: 
    Layout: {}
  Routers: {}
  Channels: {}
  Utilities: {}
    



FamilyBudget.App =  Marionette.Application.extend

  onBeforeStart: ->
    FamilyBudget.Channels.transactionsTable = Backbone.Radio.channel 'transctions_table'
    FamilyBudget.user = new UserAuth.Models.User()
    FamilyBudget.user.fetch()
    router = new FamilyBudget.Routers.Main()
    rootLayout = new FamilyBudget.Views.Layout.Root({router: router})
    @transactions = new FamilyBudget.Collections.Transactions()
    rootLayout.render()
    

  onStart: ->
    Backbone.history.start() unless Backbone.History.started
    $(document).on 'click', 'a[href^="#"]', (event) ->
      event.preventDefault()
      url =  @getAttribute('href').replace('#','')
      Backbone.history.navigate(url, { trigger: true})