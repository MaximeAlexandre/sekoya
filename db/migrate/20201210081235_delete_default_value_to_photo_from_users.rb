class DeleteDefaultValueToPhotoFromUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :photo, nil
  end
end
