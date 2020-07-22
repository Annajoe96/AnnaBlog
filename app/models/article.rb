class Article < ApplicationRecord
  paginates_per 3

  belongs_to :user

  validates :title, :body, presence: true
  validate :word_count_validate

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :publication, optional: true

  def word_count
    body.split(" ").count
  end

  def word_count_validate
    if body != nil
      if word_count < 10
        remaining = 10 - word_count
        errors.add(:body, "is too short. You need to add #{ActionController::Base.helpers.pluralize(remaining, 'word')}.")
      end
    end
  end


end
