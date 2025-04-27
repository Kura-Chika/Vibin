class Event < ApplicationRecord
  belongs_to :user  # Event は User に属する
end
