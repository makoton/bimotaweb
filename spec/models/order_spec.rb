require 'rails_helper'

describe Order do
  it 'has a valid factory' do
    expect(build(:order)).to be_valid
  end

  it 'order start' do
    user = build(:user, role: 'admin')
    order = build(:order)

    order.start!(user)
    expect(order.current_state).to eq Order::STATUS_INPROGRESS

  end

  it 'order finish' do
    user = build(:user, role: 'admin')
    order = build(:order)

    order.finish!(user)
    expect(order.current_state).to eq Order::STATUS_FINISHED

  end

  it 'order count by status' do
     create_list(:order, 25)
     expect(Order.count_by_status(Order::STATUS_NEW)).to eq 25
  end
end
