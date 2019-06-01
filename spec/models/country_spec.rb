# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Country, type: :model do

  it 'should have valid factory' do
    expect(build(:country)).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:abbreviation) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_uniqueness_of(:abbreviation).case_insensitive }
  end

  describe 'association' do
    it { should have_many(:visited_countries).dependent(:destroy) }
    it { should have_many(:trips).through(:visited_countries) }
  end
end
