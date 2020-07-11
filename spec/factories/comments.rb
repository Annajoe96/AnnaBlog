require 'faker'

FactoryBot.define do
  factory :comment do
    comment {Faker::Movies::HarryPotter.spell}
    user
    article
  end
end
