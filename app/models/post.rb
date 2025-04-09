class Post < ApplicationRecord
  has_many :goods, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :artist_posts, dependent: :destroy
  belongs_to :user
  has_one_attached :post_image

  def goods_by?(user) #現在ログインしているユーザーによっていいねされているかの確認
    goods.exists?(user_id: user.id)#既にいいねを押しているかどうか
  end

end
