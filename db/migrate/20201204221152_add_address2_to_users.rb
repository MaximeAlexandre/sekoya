class AddAddress2ToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :address2, :string
  end
end
