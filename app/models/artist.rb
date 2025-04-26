class Artist < ApplicationRecord
  has_many :artist_posts
  has_many :posts, through: :artist_posts
  has_many :artist_groups
  has_many :groups, through: :artist_groups
  belongs_to :genre
  has_one_attached :artist_image


  scope :search_by_name, ->(query, match_type) {
    if query.present?
      case match_type
      when 'partial'
        where("name LIKE ?", "%#{query}%")
      else
        where(name: query)
      end
    else
      all
    end
  }
end
