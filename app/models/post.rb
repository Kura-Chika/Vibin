class Post < ApplicationRecord
  has_many :goods, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :artist_posts, dependent: :destroy
  has_many :artists, through: :artist_posts
  belongs_to :user
  has_one_attached :post_image

  def artists_name
    artists.pluck(:name).join(" / ")
  end

  def goods_by?(user) # 現在ログインしているユーザーによっていいねされているかの確認
    return false unless user.present?
    goods.exists?(user_id: user.id) # 既にいいねを押しているかどうか
  end

  def self.user_goods(user, page, per_page) # いいね一覧
    includes(:goods) # goods テーブルを結合
      .where(goods: { user_id: user.id }) # ユーザーがいいねしたレコードを絞り込む
      .order(created_at: :desc) # 投稿を作成日時の降順でソート
      .page(page) # ページネーション
      .per(per_page) # ページごとに表示する投稿
  end

  # 検索機能
  scope :search_by_name, ->(query, match_type) {
    case match_type
    when 'partial' then where("CONCAT(title, body) LIKE ?", "%#{query}%")
    else all
    end
  }

end
