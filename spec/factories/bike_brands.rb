FactoryGirl.define do
  factory :bike_brand , class: BikeBrand do
    name {Faker::Company.name}
  end
end