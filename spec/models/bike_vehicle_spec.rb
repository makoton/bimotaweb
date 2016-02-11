require 'rails_helper'

describe Supply do
  it 'has a valid factory' do
    expect(build(:bike_vehicle)).to be_valid
  end
end