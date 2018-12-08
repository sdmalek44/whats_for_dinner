FactoryBot.define do
  factory :search do
    keyword { "MyString" }
    max_time { 1 }
    allergies { "MyText" }
  end
end
