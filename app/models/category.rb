class Category < ApplicationRecord
  has_many :transactions

  validates :title, presence: true
end
