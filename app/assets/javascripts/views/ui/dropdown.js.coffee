FamilyBudget.Views.Dropdown = Marionette.View.extend

  className: 'dropdown-wrapper'

  template: JST['ui/dropdown']

  ui:
    'input': 'input'
    'placeholder': '.js-dropdown-placeholder span'
    'dropdown': '.js-dropdown'
    'items': '.js-dropdown-list li'

  events:
    'click @ui.dropdown': 'toggleDropdown'
    'click @ui.items': 'selectItem'

  initialize: (ops) ->
    @model = new Backbone.Model
      inputName: ops.inputName
      placeholder: ops.placeholder
      items: ops.items

    @channel = 
      obj: ops.channel
      event: ops.channelEvent

  toggleDropdown: ->
    @ui.dropdown.toggleClass 'is-active'

  selectItem: (e) ->
    item = $(e.target)
    data = item.data 'value'
    text = item.text()

    @ui.input.val data
    @ui.placeholder.text text

    @ui.items.removeClass 'is-active'
    item.addClass 'is-active'

    if @channel.obj? and @channel.event
      @channel.obj.trigger @channel.event, data