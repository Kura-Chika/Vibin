class Post < ApplicationRecord
  has_many :goods, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :artist_posts, dependent: :destroy
  belongs_to :user
  has_one_attached :post_image

  def goods_by?(user) #現在ログインしているユーザーによっていいねされているかの確認
    goods.exists?(user_id: user.id)#既にいいねを押しているかどうか
  end

  # 検索機能
  scope :search_by_name, ->(query, match_type) {
    case match_type
    when 'partial' then where("CONCAT(title, body) LIKE ?", "%#{query}%")
    else all
    end
  }

end
