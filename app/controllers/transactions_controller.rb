class TransactionsController < ApplicationController
  before_filter :authorize
  respond_to :json

  def index

    transactions = current_user.transactions.all
    per_page = 20

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
    transactions = transactions.kind(filter_params[:kind]) if filter_params[:kind].present?

    if filter_params[:order].present? and filter_params[:direction].present?
      transactions = transactions.order("#{filter_params[:order]} #{filter_params[:direction]}")  
    end

    transactions = transactions.page(params[:page]).per(per_page)

    transactions_with_categories = transactions.includes(:category).to_json(
      include: { category: {only: [:id, :title]}}
    )

    render json: { 
      pagination: {
        per_page: per_page,
        current_page: transactions.current_page,
        total_pages: transactions.total_pages,
        total_transactions: transactions.total_count
      }, 
      transactions: eval(transactions_with_categories)
    }

  end

  def show
    respond_with current_user.transactions.find(params[:id])
  end

  def create
    new_transaction = Transaction.create({user: current_user}.merge(transaction_params))

    if new_transaction.save
      category = new_transaction.category
      render json: new_transaction.attributes.merge(category: category.attributes.slice('id', 'title'))
    else
      respond_with new_transaction
    end
  end

  def update
    transaction = current_user.transactions.find(params[:id])
    respond_with transaction.update(transaction_params)
  end

  def destroy
    transaction = current_user.transactions.find(params[:id])
    transaction.destroy
    respond_with transaction
  end

private

  def transaction_params
    allow = [:title, :amount, :date, :note, :kind, :currency, :category_id]
    params.permit(allow)
  end

  def filter_params
    allow = [:created_at, :date_from, :date_to, :title, :amount, :note, :kind, :category_id, :order, :direction]
    params.permit(allow)
  end

end