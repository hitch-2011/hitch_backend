class User < ApplicationRecord
  has_many :friends
  has_many :rides, dependent: :destroy
  validates :password, presence: { require: true }
  validates :password, confirmation: true
  validates :email, uniqueness: true, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :about_me, presence: true
  before_save { email.try(:downcase!) }
  has_secure_password
end
