FactoryBot.define do
  factory :user do
    username { "MyString" }
    password { "MyString" }
    email { "MyString" }
    current_token { nil }
  end
end
