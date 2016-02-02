FactoryGirl.define do
  pass = Faker::Internet.password(8)
  factory :user , class: User do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password  pass
    encrypted_password  pass
  end
end
