FactoryBot.define do
  factory :post do
    content{Faker::Lorem.sentence}
    price{200}
    calorie{300}
    association :user
    
    
  end
end