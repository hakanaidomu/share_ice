class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_one_attached :image
  validates :content, presence: true, length: { maximum: 150 }
  validates :image, presence: true
  validates :price, numericality: { less_than_or_equal_to: 1999 }, allow_blank: true
  validates :calorie, numericality: { less_than_or_equal_to: 999 }, allow_blank: true
  acts_as_taggable
end
