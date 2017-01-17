class TotalsController < ApplicationController
  before_filter :authorize
  respond_to :json

  def index
    render json: {
      credit: 1234.34,
      debit: 678.56
    }
  end

end