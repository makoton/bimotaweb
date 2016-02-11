FactoryGirl.define do
  factory :bike_vehicle , class: BikeVehicle do
    model {Faker::Company.ein}
    year {Faker::Number.between(1950, Date.today.year.to_i)}
    license_plate {Faker::Address.postcode}
    chassis_number {Faker::Number.number(10)}
    kilometraje {Faker::Number.between(1, 100000)}
    user
    bike_brand
  end
end