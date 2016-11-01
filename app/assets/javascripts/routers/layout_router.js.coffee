class FamilyBudget.Routers.Layout extends Backbone.Router

  routes:
    ''        :    'homePage'
    'home'    :    'homePage'
    'add'     :    'addPage'


  homePage: ->
    new FamilyBudget.Views.LayoutPageHome()
    console.log "home page"

  addPage: ->
    new FamilyBudget.Views.LayoutPageAdd()
    new FamilyBudget.Views.TransactionsAdd()
    console.log "add page"
