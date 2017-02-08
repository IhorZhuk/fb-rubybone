class TransactionsController < ApplicationController
  before_action :authorize
  respond_to :json
  PER_PAGE = 20

  def index
    transactions = Transaction.get_transactions_for_user(current_user, filter_params)

    @debit_sum = transactions.kind('debit').sum(:amount)
    @credit_sum = transactions.kind('credit').sum(:amount)
    @transactions = transactions.includes(:category).page(params[:page]).per(PER_PAGE)
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