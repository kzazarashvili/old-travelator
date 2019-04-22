class Trip < ApplicationRecord
  belongs_to :user
  has_many :visited_countries, dependent: :destroy
  has_many :countries, through: :visited_countries

  validates :started_at, presence: true
  validate :ended_at_being_in_past

  before_save :calculate_and_set_duration_and_past, if: :ending_date_known?

  default_scope { where(past: false) }
  scope :order_by_created_at, -> { order(created_at: :desc) }
  scope :past_trip, -> { where(past: true) }

  def self.over_limit
    calculate_avaible_number_of_days < 0
  end

  def self.in_limit
    calculate_avaible_number_of_days >= 0
  end

  def self.calculate_avaible_number_of_days
    90 - calculate_days_away
  end

  def self.calculate_duration_off_all_trips
    past_trip.sum(:duration)
  end

  private


  def self.calculate_days_away
    sum(:duration)
  end

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

    errors.add(:ended_at, I18n.t('trips.errors.ended_at'))
  rescue ArgumentError
    errors.add(:ended_at, I18n.t('trips.errors.ended_at'))
  end
end
