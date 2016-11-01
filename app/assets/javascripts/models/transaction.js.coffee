class FamilyBudget.Models.Transaction extends Backbone.Model
  
  deafults: 
    title: ''
    amount: 0
    currency: 'EUR'
    note: ''

  initialize: ->
    if @get('date') == ''
      @set({ 'date': new Date().toLocaleDateString() }) 

