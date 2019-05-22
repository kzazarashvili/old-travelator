class Trip < ApplicationRecord
  belongs_to :user
  has_many :visited_countries, dependent: :destroy
  has_many :countries, through: :visited_countries

  validates :started_at, presence: true
  validate :ended_at_being_in_past, :already_taken_dates

  before_save :calculate_and_set_duration_and_past, if: :ending_date_known?

  scope :only_active, ->(breakpoint) { where(past: false).where('ended_at >= ?', breakpoint) }
  scope :order_by_started_at, -> { order(started_at: :desc) }
  scope :persisted, -> { where('id IS NOT NULL') }

  delegate :names, to: :countries, prefix: :country

  def within_breakpoint?(breakpoint = Time.zone.today - 180 + 1)
    started_at < breakpoint && ended_at >= breakpoint
  end

  def before_breakpoint(breakpoint = Time.zone.today - 180 + 1)
    (breakpoint - started_at).to_i
  end

  def after_breakpoint(breakpoint = Time.zone.today - 180 + 1)
    (ended_at - breakpoint).to_i + 1
  end

  def counted_duration(breakpoint)
    within_breakpoint?(breakpoint) ? after_breakpoint : duration
  end

  def calculate_past(breakpoint = Time.zone.today - 180 + 1)
    ended_at < breakpoint
  end

  private

  def calculate_and_set_duration_and_past
    self.duration = calculate_duration
    self.active_duration = after_breakpoint
    self.past_duration = before_breakpoint
    self.past = calculate_past
  end

  def existing_trips
    arr = user&.trips&.persisted || []
    arr - [self]
  end

  def taken_dates
    existing_trips.map do |trip|
      start_date = trip.started_at
      end_date = trip.ended_at
      if end_date.blank?
        [start_date]
      else
        (start_date...end_date).to_a
      end
    end
  end

  def range_of_already_taken_dates
    taken_dates.flatten
  end

  def range_of_trip_dates
    return [] if (started_at.blank? || ended_at.blank?)

    (started_at...ended_at).to_a
  end

  def shared_date
    range_of_already_taken_dates & range_of_trip_dates
  end

  def already_taken_dates

    errors.add(:started_at, 'Dates are in use') if
    shared_date.any? || range_of_already_taken_dates.include?(started_at)

    errors.add(:ended_at, 'Dates are in use') if range_of_already_taken_dates.include?(ended_at)
  end

  def ending_date_known?
    ended_at.present?
  end

  def calculate_duration
    same_day? ? 1 : ((ended_at - started_at).to_i + 1)
  end

  def same_day?
    ended_at == started_at
  end

  def ended_at_being_in_past
    return if ended_at.blank?
    return if ended_at >= started_at

    errors.add(:ended_at, I18n.t('trips.errors.ended_at'))
  rescue ArgumentError
    errors.add(:ended_at, I18n.t('trips.errors.ended_at'))
  end
end
