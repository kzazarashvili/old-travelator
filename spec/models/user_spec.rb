require 'rails_helper'

RSpec.describe User, type: :model do

  it 'should have valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'associations' do
    it { should have_many :trips }
  end

  describe '.from_omniauth' do
    pending
  end

end
