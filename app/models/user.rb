class User < ApplicationRecord
  has_many :drives, dependent: :destroy
  has_many :drive_days, dependant: :destroy
  validates :email, uniqueness: true, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :make, presence: true
  validates :model, presence: true
  validates :year, presence: true
  before_save { email.try(:downcase!) }
end
