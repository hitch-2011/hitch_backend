class User < ApplicationRecord
  has_many :friends
  has_many :rides, dependent: :destroy
  validates :password, presence: { require: true }
  validates :fullname, presence: { require: true }
  validates :password, presence: { require: true }
  validates :email, uniqueness: true, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  
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
