require 'rails_helper'

RSpec.describe Ability do
  subject(:ability){ Ability.new(user) }

  describe Trip do
    context 'with associated user' do
      let!(:user) { create(:user) }
      let!(:trip) { create(:trip, user: user) }

      it { should have_abilities :manage, trip }
    end

    context 'with not associated user' do
      let!(:user) { create(:user) }
      let!(:trip) { create(:trip) }

      it { should not_have_abilities :manage, trip }
    end

    context 'not associated user can read all trips' do
      let!(:user) { create(:user) }
      let!(:trip) {create(:trip) }

      it { should have_abilities :read, trip }
    end
  end
end
