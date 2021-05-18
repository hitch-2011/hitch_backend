FactoryBot.define do
  factory :user do
    id { Faker::Number.unique.within(range: 1..100) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    about_me { 'hello it is me' }
  end
end
