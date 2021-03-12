class AddNewFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :family_first_name, :string
    add_column :users, :family_last_name, :string
  end
end
