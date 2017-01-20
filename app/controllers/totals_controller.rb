class TotalsController < ApplicationController
  before_action :authorize
  respond_to :json

  def index
    # must accept params:
    # - date_from
    # - date_to

    render json: {
      credit: 1200,
      debit: 400,
      difference: 800, #credit - totals
      currency: 'EUR'
    }
  end

end