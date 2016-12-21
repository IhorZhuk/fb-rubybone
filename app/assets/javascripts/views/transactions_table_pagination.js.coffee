FamilyBudget.Views.TransactionsPagination = Marionette.View.extend

  template: JST['transactions_table_pagination']

  className: 'pagination'

  events:
    'click li': 'onButtonClicked'

  initialize: (ops) ->
    @collection = ops.collection
    @pagination = ops.collection.pagination

  render: ->
    @$el.html( @template(@pagination) )
    @$el.find("span[data-page=#{@pagination.current_page}]").addClass 'is-active'

  onButtonClicked: (e) ->
    btn = $(e.target).closest('li').find('span')
    unless btn.data('page') == 'disabled'
      FamilyBudget.Channels.transactionsTable.trigger 'pagination:clicked', btn.data('page')

