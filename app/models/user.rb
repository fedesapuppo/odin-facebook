class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :friend_requests
  has_many :likes
  has_many :comments
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
end
