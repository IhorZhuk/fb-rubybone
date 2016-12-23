FamilyBudget.Utilities.ValidationHandler = 

  resetInvalidInputs: ->
    inputs = @$el.find('.is-invalid')
    inputs.val ''
    inputs.removeClass 'is-invalid'
    @ui.error.html('').hide()

  renderErrors: (model, errors) ->
    _.each errors, @renderError, @

  renderError:(errors, attribute) ->
    error = errors.join '; '
    @$el.find('input[name=' + attribute + ']').addClass 'is-invalid'
    @ui.error.prepend('<span>' + attribute + ' ' + error + ';</span>').show()

  parseErrorResponse: (model, resp) ->
    if resp and resp.responseText
      errors = JSON.parse resp.responseText
      @renderErrors(model, errors.errors)