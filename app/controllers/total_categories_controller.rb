class TotalCategoriesController < ApplicationController
  before_action :authorize
  respond_to :json

  def index
    @total_categories = Transaction.get_total_categories(current_user, filter_params)
    @main_currency = current_user.main_currency

    render json: @total_categories.merge(currency: @main_currency)
  end

  private

  def filter_params
    params.permit(:date_from, :date_to)
  end
end