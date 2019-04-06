class AddImageNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image, :string
    add_column :users, :name, :string
  end
end
