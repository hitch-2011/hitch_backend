FactoryBot.define do
  factory :user do
    id { Faker::Number.unique.within(range: 1..100) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    bio { 'hello it is me' }
    fullname { Faker::Name.unique.name }
  end
end
