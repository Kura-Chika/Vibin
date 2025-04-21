class Artist < ApplicationRecord
  has_many :artist_posts
  has_many :posts, through: :artist_posts
  has_many :artist_groups
  has_many :groups, through: :artist_groups
  belongs_to :genre
  has_one_attached :artist_image
end
