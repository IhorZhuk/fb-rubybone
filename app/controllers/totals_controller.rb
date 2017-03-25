class TotalsController < ApplicationController
  before_action :authorize
  respond_to :json

  def index
    @totals = Transaction.get_totals(current_user, filter_params)
  end

  private

  def filter_params
    params.permit(:date_from, :date_to)
  end

end