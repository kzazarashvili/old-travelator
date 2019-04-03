class Trip < ApplicationRecord
  belongs_to :user

  validates :started_at, presence: true
  validate :ended_at_being_in_past

  before_save :calculate_and_set_duration_and_past, if: :ending_date_known?

  private

  def calculate_and_set_duration_and_past
    self.duration = calculate_duration
    self.past = calculate_past
  end

  def ending_date_known?
    ended_at.present?
  end

  def calculate_past
    ended_at < (Date.today - 180)
  end

  def calculate_duration
    same_day? ? 1 : (ended_at - started_at).to_i
  end

  def same_day?
    ended_at == started_at
  end

  def ended_at_being_in_past
    return if ended_at.blank?
    return if ended_at >= started_at

    errors.add(:ended_at, 'cannot be before the start date')
  end
end
