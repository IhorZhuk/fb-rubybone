class User < ApplicationRecord
  has_secure_password

  validates :name, :email, presence: true
  validates_uniqueness_of :email

  has_many :transactions, dependent: :destroy
  has_many :categories, dependent: :destroy

end
