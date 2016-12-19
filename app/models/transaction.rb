class Transaction < ApplicationRecord
  belongs_to :category

  validates :title, presence: true
  validates :amount, presence: true,  numericality: true

  default_scope { order('date DESC')}

  scope :amount, -> (amount) { where amount: amount}
  scope :category, -> (category) { where category_id: category}
  scope :note, -> (note) { where 'note LIKE ?', "%#{note}%" }
  scope :title, -> (title) { where 'title LIKE ?', "%#{title}%"}
  scope :today, -> (date) { where created_at: date.beginning_of_day..date.end_of_day}
  scope :from_to, -> (from, to) { where date: from.beginning_of_day..to.end_of_day}

end
