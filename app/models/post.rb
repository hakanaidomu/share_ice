class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_one_attached :image
  has_many :comments, dependent: :destroy

  # 特定のユーザーがいいね済みかどうかを判断する
  def favorite_by(user) 
    favorites.find{|f| f.user_id == user.id}
  end
end
