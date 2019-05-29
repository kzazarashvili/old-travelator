class AddAbbreviationToCountries < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :abbreviation, :string
  end
end
