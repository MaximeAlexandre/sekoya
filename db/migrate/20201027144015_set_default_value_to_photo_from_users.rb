class SetDefaultValueToPhotoFromUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :photo, from: nil, to: "https://www.flaticon.com/svg/static/icons/svg/3237/3237472.svg"
  end
end
