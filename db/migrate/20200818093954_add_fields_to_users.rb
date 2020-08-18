class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address, :string
    add_column :users, :mobile_number, :integer
    add_column :users, :role, :string
    add_column :users, :pathology, :string
    add_column :users, :handicap, :string
    add_column :users, :diploma, :string
    add_column :users, :car, :boolean
    add_column :users, :activity_start_date, :date
    add_column :users, :description, :text
    add_column :users, :price, :integer
  end
end
