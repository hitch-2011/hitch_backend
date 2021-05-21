class User < ApplicationRecord
  has_many :friends
  has_many :rides, dependent: :destroy
  has_one :vehicle, dependent: :destroy
  validates :password, presence: { require: true }
  validates :fullname, presence: { require: true }
  validates :password, presence: { require: true }
  validates :email, uniqueness: true, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :fullname, presence: true

  before_save { email.try(:downcase!) }
  has_secure_password

  def pluck_friend_id
    Ride.where(user_id: pluck(self))
  end

  def pluck(user)
    array = []
    array << user.id
    array << user.friends.pluck(:friend_id)
    array.flatten
  end
end
