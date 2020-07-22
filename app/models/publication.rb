class Publication < ApplicationRecord
  has_many :user_publications
  has_many :users, through: :user_publications
  has_many :articles

  validates :title, uniqueness: true, presence: true
  validates :description, presence: true
end
