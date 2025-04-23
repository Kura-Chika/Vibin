class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_one_attached :user_image

  validates :nickname, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  # 検索機能
  scope :search_by_fullname, ->(query, match_type) {
    case match_type
    when 'partial' then where("nickname LIKE ?", "%#{query}%")
    else all
    end
  }
  
  # ゲストログイン
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "guestuser"
    end
  end

end