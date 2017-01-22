class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :amount, presence: true, numericality: true

  scope :amount, -> (amount) { where amount: amount }
  scope :category, -> (category) { where category_id: category }
  scope :kind, -> (kind) { where kind: kind }
  scope :note, -> (note) { where 'note LIKE ?', "%#{note}%" }
  scope :title, -> (title) { where 'title LIKE ?', "%#{title}%" }

  FILTERS = {
      amount: :amount,
      category: :category,
      kind: :kind,
      note: :note,
      title: :title,
      date_from: :date_from,
      date_to: :date_to,
      category_id: :category,
      created_at: :today
  }

  # ============ Class methods ========================

  class << self

    def apply_filters(collection=self.all, params)
      result = collection
      FILTERS.each do |filter_name, method|
        result = result.send(method, params[filter_name]) if params[filter_name].present?
      end
      result
    end

    def date_from(date)
      date = date.try(:to_date) || '01-01-1900'.to_date
      where 'date >= ?', date.beginning_of_day
    end

    def date_to(date)
      date = date.try(:to_date) || Date.today
      where 'date <= ?', date.end_of_day
    end

    def today(date)
      date = date.to_date
      where created_at: date.beginning_of_day..date.end_of_day
    end

    def get_transactions_for_user(user, filter_params)

      transactions = Transaction.apply_filters(self.where(user: user), filter_params)

      if filter_params[:order].present? and filter_params[:direction].present?
        transactions = transactions.order("#{filter_params[:order]} #{filter_params[:direction]}")
      end

      transactions
    end
  end

  # ============ Instance methods ========================

  def currency
    user.currencies.first.title
  end

end
