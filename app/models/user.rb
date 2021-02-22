class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments,dependent: :destroy
  has_one_attached :image

  validates :nickname, presence: true
  validates :email, length: { maximum: 50 }, presence: true, uniqueness: true

  mount_uploader :image, ImageUploader
end
