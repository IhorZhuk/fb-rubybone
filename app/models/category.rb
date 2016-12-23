class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :restrict_with_error

  #HOW to catch restrict with error message
  validates :title, presence: true
end
