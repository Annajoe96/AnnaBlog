class Article < ApplicationRecord
  paginates_per 3

  belongs_to :user

  validates :title, :body, presence: true
  validate :word_count_validate

  has_many :comments, dependent: :destroy

  def word_count
    body.split(" ").count
  end

  def review
    para = body.split(" ")[0..40].join(" ")
  end

  private

  def word_count_validate
    if word_count <= 10
      errors.add(:body, "your article is too short you need to add #{10-word_count} more words")
    end
  end


end
