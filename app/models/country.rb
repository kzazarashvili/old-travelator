class Country < ApplicationRecord
  has_many :visited_countries
  has_many :trips, through: :visited_countries
  
  validates :name, presence: true
end
