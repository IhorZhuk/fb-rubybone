FamilyBudget.Models.Category =  Backbone.Model.extend

  defaults:
    title: ''

  validate: (atr) ->
    if not atr.title
      @trigger 'invalid:title'
      return 'Title can\'t be blank'