class UserPublication < ApplicationRecord
  belongs_to :user
  belongs_to :publication
  
  validates :publication, :user, presence: true
  validates :publication, uniqueness: { scope: :user, message: "you've added the user already" }
end
