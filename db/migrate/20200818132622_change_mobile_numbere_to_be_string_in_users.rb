class ChangeMobileNumbereToBeStringInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :mobile_number, :string
  end
end
