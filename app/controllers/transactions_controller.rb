class TransactionsController < ApplicationController

  respond_to :json

  def index
    transactions = Transaction.all

    if filter_params[:date_from] && filter_params[:date_to] && filter_params[:date_from] != '' && filter_params[:date_to] != ''
      start_date = filter_params[:date_from].to_date
      end_date = filter_params[:date_to].to_date
      transactions = transactions.from_to(start_date, end_date)
    end

    if filter_params[:created_at]
      date = filter_params[:created_at].to_date
      transactions = transactions.today(date)
    end
    
    transactions = transactions.category(filter_params[:category_id]) if filter_params[:category_id] && filter_params[:category_id] != ''
    transactions = transactions.title(filter_params[:title]) if filter_params[:title] && filter_params[:title] != ''
    transactions = transactions.note(filter_params[:note]) if filter_params[:note] && filter_params[:note] != ''
    transactions = transactions.amount(filter_params[:amount]) if filter_params[:amount] && filter_params[:amount] !=''

    respond_with transactions.includes(:category).to_json(include: {category: {only: [:id, :title]}} )
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
    allow = [:title, :amount, :date, :note, :kind, :currency, :category_id]
    params.permit(allow)
  end

  def filter_params
    allow = [:created_at, :date_from, :date_to, :title, :amount, :note, :kind, :category_id]
    params.permit(allow)
  end

end