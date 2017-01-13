class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :restrict_with_error

  validates :title, presence: true
end
