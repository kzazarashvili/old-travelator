# == Schema Information
#
# Table name: visited_countries
#
#  id         :bigint           not null, primary key
#  trip_id    :bigint
#  country_id :bigint
#

require 'rails_helper'

RSpec.describe VisitedCountry, type: :model do

  it 'should have valid factory' do
    expect(build(:visited_country)).to be_valid
  end

  describe 'association' do
    it { should belong_to :trip }
    it { should belong_to :country }
  end
end
