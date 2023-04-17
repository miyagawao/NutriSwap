# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(
  email: 'admin@admin',
  password: 'password',
  )
  
Genre.create(
  [{ name: '献立'},
  { name: '食育'},
  { name: 'Q & A'}
  ])

5.times do |n|
  Contributor.create(
    email: "#{n + 1}@#{n + 1}",
    password: "password",
    last_name: "山田#{n + 1}",
    first_name: "#{n + 1}郎",
    last_name_kana: "ヤマダ#{n + 1}",
    first_name_kana: "#{n + 1}ロウ",
    nickname: "#{n + 1}ロー",
    postal_code: Faker::Address.postcode,
    address: Faker::Address.city_prefix + Faker::Address.city_suffix + Faker::Address.street_name + Faker::Address.building_number,
    telephone_number: Faker::PhoneNumber.phone_number,
    qualification: "管理栄養士",
    introduce: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true)
  )
end