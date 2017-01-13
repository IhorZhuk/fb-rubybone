FamilyBudget.Views.CategoriesTableRow = Marionette.View.extend

  tagName: 'tr'

  template: JST['categories/categories_table_row']

  ui:
    'btnDelete': '.js-delete'
    'btnEdit': '.js-edit'
    'titleCell': '.js-title'
    'form': '.js-title-form'
    'input': 'input[name="title"]'

  events:
    'click @ui.btnDelete': 'openDeleteModal'
    'click @ui.btnEdit': 'enableEditMode'
    'submit @ui.form': 'submit'

  initialize: ->
    @listenTo @model, 'remove', @removeView
    @listenTo @model, 'change', @render

  openDeleteModal: ->
    modal = new FamilyBudget.Views.Modal
      title: 'Delete Confirmation'
      content: new FamilyBudget.Views.ConfirmDelete
        model: @model
        template: JST['confirm_delete_category']

  enableEditMode: ->
    @ui.titleCell.toggleClass 'has-edit-mode'

  submit: (e) ->
    e.preventDefault()
    newVal = @ui.input.val()
    if newVal != ''
      @model.set({ title: newVal})
      @model.save()

  removeView: ->
    @$el.addClass 'table-row-delete'
    @$el.fadeOut()