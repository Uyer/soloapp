FactoryBot.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  factory :user do
    email
    password "idontknow"
    first_name "Mario"
    last_name "Bros"
    admin false
  factory :admin do
    first_name "Admin"
    last_name "User"
    admin true
  end
  
  end
end