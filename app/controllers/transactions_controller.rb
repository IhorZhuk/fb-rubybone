class TransactionsController < ApplicationController

  respond_to :json

  def index
    filter = nil
    if filter_params[:date]
      start_date = filter_params[:date].to_date.beginning_of_day
      end_date = filter_params[:date].to_date.end_of_day
      filter = {:created_at => start_date..end_date}

    elsif filter_params[:today]
      today = DateTime.now
      start_date = today.to_date.beginning_of_day
      end_date = today.to_date.end_of_day
      filter = {:created_at => start_date..end_date}
    end

    puts filter
    respond_with Transaction.where(filter)
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

private

  def transaction_params
    allow = [:title, :amount, :date, :note, :kind, :currency]
    params.permit(allow)
  end

  def filter_params
    allow = [:date, :today]
    params.permit(allow)
  end

end
