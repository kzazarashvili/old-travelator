require 'rails_helper'

RSpec.describe Trip, type: :model do

  it 'should have valid factory' do
    expect(build(:trip)).to be_valid
  end

  describe 'association' do
    it { should belong_to(:user) }
    it { should have_many(:visited_countries).dependent(:destroy) }
    it { should have_many(:countries).through(:visited_countries) }
  end

  describe 'validations' do
    it { should validate_presence_of :started_at }
  end
end
