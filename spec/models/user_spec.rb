require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'check role' do
    admin = build(:user, role: 'admin')
    expect(admin.role?('admin')).to be true
  end

end

