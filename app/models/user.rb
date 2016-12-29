class User < ApplicationRecord
  has_secure_password

  validates :name, :email, presence: true
  validates :password, length: { in: 4..20 }, on: :create
  validates_uniqueness_of :email
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  has_many :transactions, dependent: :destroy
  has_many :categories, dependent: :destroy

  before_create { generate_token(:auth_token) }
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

end
