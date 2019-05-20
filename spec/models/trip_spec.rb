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

    describe  'taken dates' do
      let!(:past_trip) { create(:trip) }

      context 'should not be possible to create a trip with the same strat date' do
        let!(:next_trip) { create(:trip, :start_date_taken) }
        it { expect(next_trip).to_not be_valid }
      end

      context 'should not be possible to create a trip if start date is inside second trip' do
        let!(:next_trip){ create(:trip, :start_date_in_taken_range) }
        it { expect(next_trip).to_not be_valid }
      end

      context 'should not be possible to create trip with taken days inside of range' do
        let!(:next_trip){ create(:trip, :days_inside_included_in_taken_range) }
        it { expect(next_trip).to_not be_valid }
      end

      context 'should be possible to create trip with taken end date from previous trips' do
        let!(:next_trip){ create(:trip, :start_date_match_with_previous_end_date) }
        it { expect(next_trip).to be_valid }
      end
    end
  end
end
