FactoryBot.define do
  factory :publication do
    title {Faker::Quote.robin}
    description {Faker::Quote.yoda}
  end
end
