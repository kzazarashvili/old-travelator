class CalculatorService
  LIMIT = 180
  ALLOWANCE = 90

  def initialize(trips, current_date = Time.zone.today)
    @trips = trips || []
    @breakpoint = current_date - LIMIT + 1
  end

  def over_limit?
    available_days.negative?
  end

  def available_days
    ALLOWANCE - spent_days
  end

  def spent_days
    @trips.only_active(@breakpoint).map { |trip| trip.counted_duration(@breakpoint) }.inject(0, :+)
  end
end
