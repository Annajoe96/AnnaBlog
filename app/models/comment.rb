class Comment < ApplicationRecord
  validates :comment, presence: true
  belongs_to :article
  belongs_to :user

  def find_commenter
    User.find(user_id).full_name
  end


end
