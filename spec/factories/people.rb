FactoryBot.define do
  factory :person do
    name {Faker::Name.name}
    register {Faker::Number.number(11)}
    name2 {Faker::Name.first_name} 
    birth_date  "2000-08-11 17:18:05"
    person_type    
  end
end
