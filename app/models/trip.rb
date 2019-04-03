class Trip < ApplicationRecord
  belongs_to :user
  before_create :number_of_days

  def number_of_days
    self.duration = (ended_at - started_at).to_i if ended_at.present?
  end
end
