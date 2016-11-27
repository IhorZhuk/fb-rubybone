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
    
    @action = ops.action

  test: ->
    console.log 'channel was trigger'

  toggleDropdown: ->
    @ui.dropdown.toggleClass 'is-active'

  selectItem: (e) ->
    item = $(e.target)
    data = item.data 'value'
    text = item.text()

    @ui.placeholder.text text
    @ui.items.removeClass 'is-active'
    item.addClass 'is-active'
    @ui.input.val data

    if  @action? then @action()