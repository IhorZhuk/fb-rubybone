class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :amount, presence: true,  numericality: true

  scope :amount, -> (amount) { where amount: amount}
  scope :category, -> (category) { where category_id: category}
  scope :kind, -> (kind) { where kind: kind}
  scope :note, -> (note) { where 'note LIKE ?', "%#{note}%" }
  scope :title, -> (title) { where 'title LIKE ?', "%#{title}%"}
  scope :today, -> (date) { where created_at: date.beginning_of_day..date.end_of_day}
  scope :from_to, -> (from, to) { where date: from.beginning_of_day..to.end_of_day}

end
