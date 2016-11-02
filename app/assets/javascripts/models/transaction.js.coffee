class FamilyBudget.Models.Transaction extends Backbone.Model
  
  defaults: 
    title: ''
    amount: 0
    currency: 'EUR'
    note: '',
    kind: ''

  initialize: ->
    @setAttrs()

  setAttrs: ->
    if @get('date') == ''
      now = new Date()
      formatDate = now.getFullYear() + '-' + now.getMonth() + '-' + now.getDay()
      @set({ 'date': formatDate })