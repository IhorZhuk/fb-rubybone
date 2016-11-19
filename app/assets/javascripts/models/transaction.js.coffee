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

  validate: (attrs) ->
    if not attrs.amount and not attrs.title
      @trigger 'invalid:amount:title'
      return 'Title and amount can\'t be blank'

    if not attrs.title
      @trigger 'invalid:title'
      return 'Title can\'t be blank'

    if not attrs.amount or attrs.amount <= 0
      @trigger 'invalid:amount'
      return 'Amount can\'t be blank or be equalt to zero'
