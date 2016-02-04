require 'rails_helper'

describe Supply do
  it 'has a valid factory' do
    expect(build(:supply)).to be_valid
  end

  it 'add stock'do
    supply = build(:supply)
    supply.add_units(5)
    expect(supply.supply_items.count).to eq 5
  end

end