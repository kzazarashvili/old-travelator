class EndedAtBeingInPastValidator < ActiveModel::Validator
  def validate(record)
    return if record.ended_at.blank?
    return if record.ended_at >= record.started_at

    record.errors.add(:ended_at, I18n.t('trips.errors.ended_at'))
  rescue ArgumentError
    record.errors.add(:ended_at, I18n.t('trips.errors.ended_at'))
  end
end
