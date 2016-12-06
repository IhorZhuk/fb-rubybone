class Transaction < ApplicationRecord
  belongs_to :category

  validates :title, presence: true
  validates :amount, presence: true,  numericality: true
end
