FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content {Faker::Lorem.sentence}
    association :post
    association :user
  end
end