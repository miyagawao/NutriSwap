FactoryBot.define do
  factory :contributor do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    last_name { Faker::Lorem.characters(number: 5) }
    first_name { Faker::Lorem.characters(number: 5) }
    last_name_kana { Faker::Lorem.characters(number: 5) }
    first_name_kana { Faker::Lorem.characters(number: 5) }
    nickname { Faker::Lorem.characters(number: 5) }
    postal_code { Faker::Address.zip_code }
    address { Faker::Address.full_address }
    telephone_number { Faker::PhoneNumber.phone_number }
    qualification { ['管理栄養士', '栄養士', '調理師', '調理従事者'].sample }
    introduce { Faker::Lorem.characters(number: 100) }
    
    after(:build) do |contributor|
      contributor.profile_image.attach(io: File.open('spec/images/no_image.jpg'), filename: 'no_image.jpg', content_type: 'image/jpg')
    end
  end
end