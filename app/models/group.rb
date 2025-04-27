class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :permits, dependent: :destroy
  has_many :users, through: :group_users, source: :user
  has_many :artist_groups, dependent: :destroy
  has_many :artists, through: :artist_groups
  belongs_to :owner, class_name: 'User'
  has_one_attached :group_image

  def artists_name
    artists.pluck(:name).join(" / ")
  end

  def is_owned_by?(user)
    owner.id == user.id
  end
  
  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end
end
