class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.date :started_at, null: false
      t.date :ended_at
      t.integer :duration, default: 0
      t.references :user, foreign_key: true
      t.boolean :past, default: false

      t.timestamps
    end
  end
end
