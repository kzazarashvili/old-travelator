# == Schema Information
#
# Table name: trips
#
#  id              :bigint           not null, primary key
#  started_at      :date             not null
#  ended_at        :date
#  duration        :integer          default(0)
#  user_id         :bigint
#  past            :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  active_duration :integer
#  past_duration   :integer
#

class Trip < ApplicationRecord
  belongs_to :user
  has_many :visited_countries, dependent: :destroy
  has_many :countries, through: :visited_countries

  validates :started_at, presence: true
  validates_with EndedAtBeingInPastValidator, AlreadyTakenDatesValidator

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

  def ending_date_known?
    ended_at.present?
  end

  def calculate_duration
    same_day? ? 1 : ((ended_at - started_at).to_i + 1)
  end

  def same_day?
    ended_at == started_at
  end
end
