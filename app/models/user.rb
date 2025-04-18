class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
  has_many :comments
  has_many :goods
  has_many :group_users

  # 検索機能
  scope :search_by_fullname, ->(query, match_type) {
    case match_type
    when 'partial' then where("nickname LIKE ?", "%#{query}%")
    else all
    end
  }

end
