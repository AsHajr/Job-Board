FactoryBot.define do
  factory :job do
    title { "MyString" }
    description { "MyString" }
    created_by { "MyString" }
    expiry_date{"2022-09-14T15:32:56.907Z".to_date}
  end
end
