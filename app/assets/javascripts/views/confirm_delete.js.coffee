FamilyBudget.Views.ConfirmDelete = Marionette.View.extend
  
  # NOTE
  # Template must be specified when creating instance
  
  ui:
    'error' : '.js-error'

  events: 
    'click .js-delete': 'deleteModel'

  submitModal: ->
    @model.destroy
      success: =>
        @triggerMethod 'modal:close'
      error: (model, res) =>
        console.log 'error'
        @ui.error.text('Error in deleting').fadeIn()
      changes: ''
