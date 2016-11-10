class FamilyBudget.Views.ModalForm extends Backbone.View

  template: JST['modals/modal_form']

  el: 'body'

  initialize: ->
    @listenTo Backbone,'modal:open', @render
    @listenTo Backbone, 'modal:close', @remove

  render: ->
    @$el.html( @template() )
    @

  remove: ->
    @$el.remove()