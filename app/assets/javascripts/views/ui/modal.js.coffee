FamilyBudget.Views.Modal = Marionette.View.extend

  template: JST['ui/modal']

  ui:
    'close' : '.js-modal-close'
    'submit': '.js-modal-submit'

  events:
    'click @ui.close' : 'closeModal'
    'click @ui.submit' :'submitModal'

  childViewEvents: 
    'modal:close': 'closeModal'

  regions:
    'content' : '.js-modal-content'

  initialize: (ops) ->
    @data =
      title: ops.title
      content: ops.content
    @render()
  
  closeModal: ->
    @$el.fadeOut().remove()

  submitModal: ->
    @data.content.submitModal()

  render: ->
    @$el.html @template(@data)
    $('body').prepend @$el
    @showChildView 'content', @data.content