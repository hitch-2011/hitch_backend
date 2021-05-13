FactoryBot.define do
  factory :ride do
    user { nil }
    origin { "MyString" }
    destination { "MyString" }
    departure_time { "MyString" }
  end
end
