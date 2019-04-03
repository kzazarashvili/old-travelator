class Trip < ApplicationRecord
  belongs_to :user

  validates :started_at, presence: true

  before_save :calculate_and_set_duration, if: :ending_date_known?

  private

  def calculate_and_set_duration
    self.duration = calculate_duration
  end

  def ending_date_known?
    ended_at.present?
  end

  def calculate_duration
    (ended_at - started_at).to_i
  end
end
