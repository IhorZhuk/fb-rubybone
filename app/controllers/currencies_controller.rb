class CurrenciesController < ApplicationController
  before_filter :authorize
  respond_to :json

  def index
    respond_with current_user.currencies.first
  end

  def create
    respond_with Currency.create(
      user: current_user,
      title: params[:title]
    )
  end

  def update
    respond_with current_user.currencies.first.update(currency_params)
  end

private

  def currency_params
    params.permit([:title])
  end

end
