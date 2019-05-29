class AddShortNameToCountries < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :short_name, :string
  end
end
