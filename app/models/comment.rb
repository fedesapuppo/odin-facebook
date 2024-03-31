class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: { message: 'You cannot post an empty comment, write something!' }
end
