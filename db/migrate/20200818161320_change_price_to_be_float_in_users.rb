class ChangePriceToBeFloatInUsers < ActiveRecord::Migration[6.0]
  def change
      change_column :users, :price, :float
  end
end
