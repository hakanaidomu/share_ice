class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments,dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_one_attached :image

  validates :nickname, presence: true, length: { maximum: 8 }
  validates :email, length: { maximum: 50 }, presence: true, uniqueness: true
  validates :description, length: { maximum: 150 }
  mount_uploader :image, ImageUploader

  
  def self.guest
    find_or_create_by!(nickname: 'ゲストユーザー', email: 'guest@example.com', description: 'こんにちわゲストユーザーさん！ゲストユーザーのため編集はできません。') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
