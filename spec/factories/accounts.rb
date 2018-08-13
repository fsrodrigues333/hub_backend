FactoryBot.define do
  factory :account do
    name {Faker::Name.first_name}
    date "2018-08-11 17:18:05"
    person
    account_type
    active {Faker::Boolean.boolean}
  end
end
