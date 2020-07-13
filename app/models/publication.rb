class Publication < ApplicationRecord
  has_many :user_publications
  has_many :users, through: :user_publications

  validates :title, uniqueness: true, presence: true
  validates :description,presence: true
end
