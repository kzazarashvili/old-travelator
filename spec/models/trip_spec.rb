require 'rails_helper'

RSpec.describe Trip, type: :model do

  it 'should have valid factory' do
    expect(build(:trip)).to be_valid
  end

  describe 'association' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :started_at }
  end

end
