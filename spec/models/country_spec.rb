require 'rails_helper'

RSpec.describe Country, type: :model do

  it 'should have valid factory' do
    expect(build(:country)).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'association' do
    it { should have_many(:visited_countries).dependent(:destroy) }
    it { should have_many(:trips).through(:visited_countries) }
  end
end
