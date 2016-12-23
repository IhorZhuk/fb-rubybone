window.UserAuth = 
  Models: {}
  Views: {}
  Routers: {}
    

UserAuth.App =  Marionette.Application.extend

  initialize: ->
    router = new UserAuth.Routers.Main()
    layout = new UserAuth.Views.Layout({router: router})
    layout.render()
    

  onStart: ->
    Backbone.history.start() unless Backbone.History.started
    $(document).on 'click', 'a[href^="#"]', (event) ->
      event.preventDefault()
      url =  @getAttribute('href').replace('#','')
      Backbone.history.navigate(url, { trigger: true})