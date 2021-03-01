class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_one_attached :image
  validates :content, presence: true
  validates :image, presence: true
  acts_as_taggable
end
