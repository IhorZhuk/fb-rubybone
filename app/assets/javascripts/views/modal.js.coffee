FamilyBudget.Views.Modal = Marionette.View.extend

  template: JST['modal']

  ui:
    'overlay' : '.js-modal-close'

  events:
    'click @ui.overlay' : 'closeModal'

  regions:
    'content' : '.js-modal-content'

  childViewEvents: 
    'modal:close': 'closeModal'

  initialize: (ops) ->
    @data =
      title: ops.title
      content: ops.content
    @render()
  
  closeModal: ->
    @$el.fadeOut().remove()

  render: ->
    @$el.html @template(@data)
    $('body').prepend @$el
    @showChildView 'content', @data.content