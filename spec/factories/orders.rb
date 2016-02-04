FactoryGirl.define do
  factory :order , class: Order do
    current_state Order::STATUS_NEW
  end
end