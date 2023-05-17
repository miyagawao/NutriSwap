FactoryBot.define do
  factory :post do
    title  { Faker::Lorem.characters(number: 20) }
    content  { Faker::Lorem.characters(number: 100) }
    status { ['draft', 'published'].sample }
    association :contributor
    
    
    after(:build) do |post|
      post.image.attach(io: File.open('spec/images/post_sample.jpg'), filename: 'post_sample.jpg', content_type: 'image/jpg')
    end
  end
end