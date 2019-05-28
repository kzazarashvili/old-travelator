# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  image                  :string
#  name                   :string
#  admin                  :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe User, type: :model do

  it 'should have valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'associations' do
    it { should have_many(:trips).dependent(:destroy) }
  end

  describe '.from_omniauth' do
    pending
  end
end
