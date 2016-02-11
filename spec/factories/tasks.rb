FactoryGirl.define do
  factory :task , class: Task do
    order
    labor_cost {Faker::Commerce.price}
    price {Faker::Commerce.price}
    total_amount {labor_cost + price}
    title {Faker::Lorem.word}
    observations {Faker::Lorem.paragraph}
    status Task::STATUS_PENDING
  end
end