FamilyBudget.Views.ConfirmDelete = Marionette.View.extend
  
  template: JST['confirm_delete']

  ui:
    'error' : '.js-error'

  events: 
    'click .js-delete': 'deleteModel'
    
  triggers: 
    'click .js-cancel': 'modal:close'

  deleteModel: ->
    that = @
    collection = @model.collection
    @model.destroy
      success: ->
        that.triggerMethod 'modal:close'
      error: (model, res) ->
        that.ui.error.text('Error in deleting').fadeIn()
      changes: ''
