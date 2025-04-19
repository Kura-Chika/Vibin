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

  def save_artist_post
    # タグが存在していれば、タグの名前を配列として全て取得
      current_tags = self.artist_post_tags.pluck(:name) unless self.artist_tags.nil?
      # 現在取得したタグから送られてきたタグを除いてoldtagとする
      old_tags = current_tags - tags
      # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
      new_tags = tags - current_tags
  
      # 古いタグを消す
      old_tags.each do |old_name|
        self.artist.delete Artist.find_by(name:old_name)
      end
  
      # 新しいタグを保存
      new_tags.each do |new_name|
        artist = Artist.find_or_create_by(name:new_name)
        self.artists << artist
      end
    end

end
