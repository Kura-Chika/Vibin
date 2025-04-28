class Genre < ApplicationRecord
  has_many :artists

  validates :name, length: { maximum: 30 }, presence: true, uniqueness: true
end
