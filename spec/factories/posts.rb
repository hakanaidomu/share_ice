FactoryBot.define do
  factory :post do
    content { Faker::Lorem.sentence }
    price { 200 }
    calorie { 300 }
    association :user
    after(:build) do |post|
      post.image.attach(io: File.open('app/assets/images/default_image.jpg'), filename: 'test_image.png')
    end
  end
end
