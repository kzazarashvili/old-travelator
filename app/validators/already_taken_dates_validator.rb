class AlreadyTakenDatesValidator < ActiveModel::Validator
  def validate(record)
    if shared_date(record).any? || range_of_previous_trips(record).include?(record.started_at)
      record.errors.add(:started_at, 'Dates are in use')
    end

    if range_of_previous_trips(record).include?(record.ended_at)
      record.errors.add(:ended_at, 'Dates are in use')
    end
  end

  private

  def shared_date(record)
    range_of_previous_trips(record) & new_trip_date_range(record)
  end

  def range_of_previous_trips(record)
    use_dates(record).flatten
  end

  def new_trip_date_range(record)
    return [] if record.started_at.blank? || record.ended_at.blank?

    (record.started_at...record.ended_at).to_a
  end

  def use_dates(record)
    existing_trips(record).map do |trip|
      start_date = trip.started_at
      end_date = trip.ended_at
      if end_date.blank?
        [start_date]
      else
        (start_date...end_date).to_a
      end
    end
  end

  def existing_trips(record)
    arr = record.user&.trips&.persisted || []
    arr - [record]
  end
end
