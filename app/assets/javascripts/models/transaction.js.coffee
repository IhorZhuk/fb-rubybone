FamilyBudget.Models.Transaction =  Backbone.Model.extend

  defaults: 
    title: ''
    currency: 'EUR'
    note: ''
    kind: ''

  initialize: ->
    @setDefaults()

  setDefaults: ->

    if @get('date') == ''
      now = new Date()
      formatDate = now.getFullYear() + '-' + (now.getMonth() + 1) + '-' + now.getDate()
      @set({ 'date': formatDate })

  validate: (attrs, ops) ->
    errors = {}
    unless attrs.title
      errors.title = ["can't be blank"]
    unless attrs.amount
      errors.amount = ["can't be blank"]
    errors unless _.isEmpty errors