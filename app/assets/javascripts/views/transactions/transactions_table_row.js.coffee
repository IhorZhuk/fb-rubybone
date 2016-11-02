class FamilyBudget.Views.TransactionsTableRow extends Backbone.View

  template: JST['transactions/row']

  tagName: 'tr'

  events: 
    'click .js-delete-transaction': 'destroy'
    'click .js-edit-transaction': 'edit'

  initialize: ->
    @render()

  render: ->
    @$el.html( @template(@model.toJSON()) )
    @

  destroy: ->
    row = @$el
    @model.destroy success: () ->
      row.remove()