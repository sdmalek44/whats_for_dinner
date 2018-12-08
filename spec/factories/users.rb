FactoryBot.define do
  factory :user do
    email { "MyString" }
    password_digest { "MyString" }
    token { "" }
  end
end
