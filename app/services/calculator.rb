
class Calculator
  LIMIT = 180
  ALLOWANCE = 90

  def initialize(trips, current_date = Time.zone.today)
    @trips = trips || []
    @breakpoint = current_date - LIMIT + 1
  end

  def over_limit?
    calculate_avaible_number_of_days.negative?
  end

  def calculate_avaible_number_of_days
    ALLOWANCE - days_spent
  end

  def days_spent
    @trips.only_active.map(&:counted_duration).inject(:+)
  end

  def days_left
    ALLOWANCE - days_spent
  end
end
