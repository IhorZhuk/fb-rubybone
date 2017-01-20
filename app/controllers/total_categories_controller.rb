class TotalCategoriesController < ApplicationController
  before_action :authorize
  respond_to :json

  def index
    # must accept params:
    # - date_from
    # - date_to


    render json: {
      currency: 'EUR',
      credit: [
        {
          title: 'Salary',
          amount: 2346
        },
        {
          title: 'Bonus',
          amount: 12
        }
      ],
      debit: [
        {
          title: 'Food',
          amount: 324
        },
        {
          title: 'Household items',
          amount: 133
        },
        {
          title: 'Another cat',
          amount: 567
        }
      ]
    }
  end

end