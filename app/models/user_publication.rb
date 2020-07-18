class UserPublication < ApplicationRecord
  belongs_to :user
  belongs_to :publication
  attr_accessor :email

  validates :publication, :user, presence: true
  validates :publication, uniqueness: { scope: :user, message: "you've added the user already" }

  before_validation :set_user

  def set_user
    self.user = User.find_by_email(self.email)
  end

end
