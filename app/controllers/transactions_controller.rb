class TransactionsController < ApplicationController

  respond_to :json

  def index
    filter = nil

    if filter_params[:date_from] && filter_params[:date_to]
      start_date = filter_params[:date_from].to_date.beginning_of_day
      end_date = filter_params[:date_to].to_date.end_of_day
      filter = {:date => start_date..end_date}
      
    elsif filter_params[:date_from]
      date = filter_params[:date_from].to_date
      filter = {:created_at => date.beginning_of_day..date.end_of_day}
    end

    respond_with Transaction.where(filter)
  end

  def show
    respond_with Transaction.find(params[:id])
  end

  def create
     respond_with Transaction.create(transaction_params)
  end

  def update
    transaction = Transaction.find(params[:id])
    respond_with transaction.update(transaction_params)
  end

  def destroy
    respond_with Transaction.destroy(params[:id])
  end

private

  def transaction_params
    allow = [:title, :amount, :date, :note, :kind, :currency]
    params.permit(allow)
  end

  def filter_params
    allow = [:date_from, :date_to]
    params.permit(allow)
  end

end
