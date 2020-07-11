require 'faker'

FactoryBot.define do
  factory :article do
    title {Faker::TvShows::Friends.quote}
    body {Faker::Lorem.paragraph(sentence_count: 10)}
    user
  end
end
