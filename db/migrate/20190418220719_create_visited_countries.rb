class CreateVisitedCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :visited_countries do |t|
      t.references :trip, foreign_key: true
      t.references :country, foreign_key: true
    end
  end
end
