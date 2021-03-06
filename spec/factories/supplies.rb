FactoryGirl.define do
  factory :supply , class: Supply do
    brand {Faker::Company.name}
    model {Faker::Company.ein}
    price {Faker::Commerce.price}
    type 'PartSupply'
    category {Faker::App.name}
  end
end