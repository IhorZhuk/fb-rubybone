class TransactionsController < ApplicationController

  respond_to :json

  def index

    transactions = Transaction.all

    d_f = filter_params[:date_from].try(:to_date) || '01-01-1900'.to_date
    d_t = filter_params[:date_to].try(:to_date) || Date.today
    
    transactions = transactions.from_to(d_f, d_t)

    if filter_params[:created_at]
      date = filter_params[:created_at].to_date
      transactions = transactions.today(date)
    end
    
    transactions = transactions.category(filter_params[:category_id]) if filter_params[:category_id].present?
    transactions = transactions.title(filter_params[:title]) if filter_params[:title].present?
    transactions = transactions.note(filter_params[:note]) if filter_params[:note].present?
    transactions = transactions.amount(filter_params[:amount]) if filter_params[:amount].present?

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