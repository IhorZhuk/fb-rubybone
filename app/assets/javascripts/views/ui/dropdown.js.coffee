# NOTE
#here are a few dropdown views

class FamilyBudget.Views.Dropdown extends Marionette.View

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

  onRender: ->
    @ui.input.val(@model.attributes.items[0])

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

    @triggerMethod 'dropdown:updated', @



class FamilyBudget.Views.DropdownDates extends Marionette.View

  className: 'dropdown-wrapper'

  template: JST['ui/dropdown_dates']

  ui:
    'dateFrom': 'input[name="date_from"]'
    'dateTo': 'input[name="date_to"]'
    'placeholder': '.js-dropdown-placeholder span'
    'dropdown': '.js-dropdown'
    'items': '.js-dropdown-list li'

  events:
    'click @ui.dropdown': 'toggleDropdown'
    'click @ui.items': 'selectItem'

  initialize: (ops) ->
    @model = new Backbone.Model
      placeholder: 'this month'
      items: ['this month', 'last month', 'this week', 'last week']

    @channel = 
      obj: ops.channel
      event: ops.channelEvent

    @dates = FamilyBudget.Utilities.Dates.getThisMonth()

  onRender: ->
    @setDates(@dates)
    
  setDates: (dates) ->
    @ui.dateFrom.val dates.from
    @ui.dateTo.val dates.to

  toggleDropdown: ->
    @ui.dropdown.toggleClass 'is-active'

  selectItem: (e) ->
    item = $(e.target)
    data = item.data 'value'
    text = item.text()

    @ui.placeholder.text text
    @ui.items.removeClass 'is-active'
    item.addClass 'is-active'

    switch data
      when 'this month'
        @setDates FamilyBudget.Utilities.Dates.getThisMonth()
      when 'this week'
        @setDates FamilyBudget.Utilities.Dates.getThisWeek()
      when 'last month'
        @setDates FamilyBudget.Utilities.Dates.getLastMonth()
      when 'last week'
        @setDates FamilyBudget.Utilities.Dates.getLastWeek()

    if @channel.obj? and @channel.event
      @channel.obj.trigger @channel.event, data

    @triggerMethod 'dropdown:updated', @