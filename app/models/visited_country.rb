# == Schema Information
#
# Table name: visited_countries
#
#  id         :bigint           not null, primary key
#  trip_id    :bigint
#  country_id :bigint
#

class VisitedCountry < ApplicationRecord
  belongs_to :trip
  belongs_to :country
end
