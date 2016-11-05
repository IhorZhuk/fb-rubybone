class FamilyBudget.Models.Transaction extends Backbone.Model
  
  defaults: 
    title: ''
    amount: 0
    currency: 'EUR'
    note: ''
    kind: ''

  initialize: ->
    @setDefaults()
    console.log @toJSON()

  setDefaults: ->

    if @get('date') == ''
      now = new Date()
      formatDate = now.getFullYear() + '-' + now.getMonth() + '-' + now.getDay()
      @set({ 'date': formatDate })

    # if @get('amount') == '' then @set({amount: 0})

    # if @get('currency') == null then @set({currency: 'EUR'})
