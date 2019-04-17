module TripsHelper
  def formated_date(date)
    date&.strftime('%B %d, %Y')
  end
end
