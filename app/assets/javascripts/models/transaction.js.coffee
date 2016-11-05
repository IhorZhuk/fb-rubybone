class FamilyBudget.Models.Transaction extends Backbone.Model
  
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
      formatDate = now.getFullYear() + '-' + now.getMonth() + '-' + now.getDay()
      @set({ 'date': formatDate })

  validate: (attrs) ->
    if not attrs.amount and not attrs.title
      Backbone.trigger 'amount:title:invalid'
      return 'Invalid'

    if not attrs.title
      Backbone.trigger 'title:invalid'
      return 'Invalid'

    if not attrs.amount or attrs.amount <= 0
      Backbone.trigger 'amount:invalid'
      return 'Invalid'
