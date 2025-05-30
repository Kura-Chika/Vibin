class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :body, presence: true, length: { minimum: 1, maximum: 100 }

  scope :search_by_body, ->(query, match_type) {
    if query.present?
      case match_type
      when 'partial'
        where("body LIKE ?", "%#{query}%")
      else
        where(body: query)
      end
    else
      all
    end
  }
end
