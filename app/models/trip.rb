class Trip < ApplicationRecord
  belongs_to :user
  validates :started_at, presence: true
  before_create :number_of_days


  def number_of_days
    if ended_at.present?
      self.duration = (ended_at - started_at).to_i
    else
      self.duration = 0
    end
  end
end
