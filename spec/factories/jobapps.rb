FactoryBot.define do
  factory :jobapp do
    created_by { "MyString" }
    status { false }
    job { nil }
  end
end
