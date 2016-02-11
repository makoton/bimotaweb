require 'rails_helper'

describe Supply do
  it 'has a valid factory' do
    expect(build(:vehicle)).to be_valid
  end
end
