FactoryBot.define do
  factory :profile do
    user { nil }
    name { "MyString" }
    surname { "MyString" }
    date_of_birth { "2024-04-12" }
    bio { "MyText" }
    phone_number { "MyString" }
    profile_picture { "MyString" }
  end
end
