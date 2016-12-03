FamilyBudget.Views.ConfirmDelete = Marionette.View.extend
  
  # NOTE
  # Template must be specified when creating instance
  
  ui:
    'error' : '.js-error'

  events: 
    'click .js-delete': 'deleteModel'

  submitModal: ->
    collection = @model.collection
    @model.destroy
      success: =>
        @triggerMethod 'modal:close'
      error: (model, res) =>
        @ui.error.text('Error in deleting').fadeIn()
      changes: ''
