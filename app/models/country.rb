# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Country < ApplicationRecord
  has_many :visited_countries, dependent: :destroy
  has_many :trips, through: :visited_countries

  validates :name, :abbreviation, presence: true, validates :name, uniqueness : { case_sensitive: false }

  def self.names
    pluck(:name).join(', ')
  end
end
