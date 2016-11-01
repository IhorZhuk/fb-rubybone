class TransactionsController < ApplicationController

  respond_to :json

  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find(params[:id])
  end

  def create
     respond_with Transaction.create(transaction_params)
  end

  def update
    respond_with Transaction.update(transaction_params)
  end

  def destroy
    respond_with Transaction.destroy(params[:id])
  end

  def Transaction_params
    allow = [:title, :amount, :date, :currency, :note]
    params.require(:Transaction).permit(allow)
  end

end
