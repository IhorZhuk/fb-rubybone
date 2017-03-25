FamilyBudget.Views.ConfirmDelete = Marionette.View.extend
  
  # NOTE
  # Template must be specified when creating instance

  initialize: (ops) ->
    @additionalData = ops.additionalData
    console.log 

  serializeData: ->
    data = @model.toJSON()
    if @additionalData?
      data = $.extend(data, @additionalData)
    data
  
  ui:
    'error' : '.js-error'

  events: 
    'click .js-delete': 'deleteModel'

  submitModal: ->
    @model.destroy
      success: =>
        @triggerMethod 'modal:close'
      error: (model, res) =>
        @ui.error.text(JSON.parse(res.responseText).errors.base[0]).fadeIn()
      changes: ''
