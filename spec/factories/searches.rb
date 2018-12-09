FactoryBot.define do
  factory :search do
    keyword { "MyString" }
    max_time { 35 }
    allergies { "thing" }
  end
end
