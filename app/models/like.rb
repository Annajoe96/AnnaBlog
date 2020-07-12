class Like < ApplicationRecord
  paginates_per 3

  belongs_to :article
  belongs_to :user

  validates :article_id, :user_id, presence: true

  validates :article, uniqueness: { scope: :user, message: "you can't like the same article more than once" }

end
