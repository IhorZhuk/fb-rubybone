FamilyBudget.Views.TransactionsEmpty = Marionette.View.extend

   className: 'empty-wrapper'
   
   template: JST['transactions/transactions_empty']

   initialize: (ops) ->
    @model = new Backbone.Model
      message: ops.message