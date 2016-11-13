class FamilyBudget.Views.ModalForm extends Backbone.View

  template: JST['modals/modal_form']

  className: 'modal-wrapper'

  events: 
    'click .js-modal-close': 'remove'

  initialize: (opts) ->
    @title = opts.title
    @listenTo Backbone,'modal:open', @render
    @listenTo Backbone, 'modal:close', @remove

  render: ->
    @$el.html( @template({title: @title}) )
    $('body').append @$el
    @

  remove: ->
    @$el.fadeOut()
    @$el.remove()
