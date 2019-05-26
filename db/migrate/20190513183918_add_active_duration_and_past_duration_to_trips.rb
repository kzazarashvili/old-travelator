class AddActiveDurationAndPastDurationToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :active_duration, :integer
    add_column :trips, :past_duration, :integer
  end
end
