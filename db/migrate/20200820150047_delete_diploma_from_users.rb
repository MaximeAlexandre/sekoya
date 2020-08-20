class DeleteDiplomaFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :diploma, :string
  end
end
