class Trip < ApplicationRecord
  belongs_to :user
  has_many :visited_countries, dependent: :destroy
  has_many :countries, through: :visited_countries

  validates :started_at, presence: true
  validate :ended_at_being_in_past

  before_save :calculate_and_set_duration_and_past, if: :ending_date_known?

  scope :only_active, ->(breakpoint) { where(past: false).where('ended_at >= ?', breakpoint) }
  scope :order_by_created_at, -> { order(created_at: :desc) }

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

  private

  def calculate_and_set_duration_and_past(breakpoint = Time.zone.today - 180 + 1)
    self.duration = calculate_duration
    self.active_duration = after_breakpoint
    self.past_duration = before_breakpoint
    self.past = calculate_past
  end

  def ending_date_known?
    ended_at.present?
  end

  def calculate_past(breakpoint = Time.zone.today - 180 + 1)
    ended_at < breakpoint
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
