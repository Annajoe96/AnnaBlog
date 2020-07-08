class Comment < ApplicationRecord
  paginates_per 3
  validates :comment, presence: true
  belongs_to :article
  belongs_to :user

  def find_commenter
    User.find(user_id).full_name
  end

  def commenter
    User.find(user_id)
  end


end
