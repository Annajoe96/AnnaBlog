class Article < ApplicationRecord

  validates :title, :author, :body, presence: true
  validate :word_count_validate

  has_many :comments, dependent: :destroy

  def word_count
    body.split(" ").count
  end

  private

  def word_count_validate
    if word_count <= 10
      errors.add(:body, "your article is too short you need to add #{10-word_count} more words")
    end
  end

end
