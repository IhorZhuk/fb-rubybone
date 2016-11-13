class FamilyBudget.Views.TransactionsDeleteConfirm extends Backbone.View

  template: JST['transactions/delete_confirm']

  events:
    'click .js-delete' : 'destroy'
    'click .js-cancel' : 'cancel'

  initialize: (opts) ->
    @row = opts.row
    @render()

  render: ->
    @$el.html( @template() )

  cancel: ->
    Backbone.trigger 'modal:close'

  destroy: ->
    that = @
    @model.destroy success: () ->
      Backbone.trigger 'transactionAdded'
      Backbone.trigger 'modal:close'