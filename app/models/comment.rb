class Comment < ApplicationRecord
  paginates_per 3
  validates :comment, presence: true
  
  belongs_to :article
  belongs_to :user
end
