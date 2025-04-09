class Post < ApplicationRecord
  has_many :goods, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :artist_posts, dependent: :destroy
  belongs_to :user
  has_one_attached :post_image
end
