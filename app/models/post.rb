class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_rich_text :content

  validates :content, presence: true
  validates :title, presence: true
end
