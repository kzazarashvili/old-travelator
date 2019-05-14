namespace :trip do

  task calculate_days: :environment do
    Trip.only_active(Time.zone.yesterday - 180 + 1).each do |trip|
      trip.update(
        past: trip.calculate_past,
        active_duration: trip.after_breakpoint,
        past_duration: trip.before_breakpoint
      )
    end
    puts "done"
  end

end
