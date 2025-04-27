class User < ApplicationRecord
  before_create :set_active

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :permits, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :owned_groups, class_name: "Group"
  has_many :events  # User は複数の Event を持つ
  has_one_attached :user_image

  validates :nickname, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  # 検索機能
  scope :search_by_fullname, ->(query, match_type) {
    if query.present?
      case match_type
      when 'partial'
        where("nickname LIKE ?", "%#{query}%")
      else # 完全一致
        where(nickname: query)
      end
    else
      all
    end
  }
  
  # 退会しているユーザーはログインできないようにする
  def active_for_authentication?
    super && is_active?
  end

  # ゲストログイン
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "guestuser"
    end
  end

  private

  def set_active
    self.is_active = true if is_active.nil?
  end

end