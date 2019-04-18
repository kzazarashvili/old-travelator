class Country < ApplicationRecord
  has_many :visited_countries, dependent: :destroy
  has_many :trips, through: :visited_countries

  validates :name, presence: true
end
