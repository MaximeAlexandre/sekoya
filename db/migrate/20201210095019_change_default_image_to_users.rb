class ChangeDefaultImageToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :photo, from: "https://res.cloudinary.com/dh78qytaz/image/upload/v1607589287/login_vt9lqi.png", to: "https://res.cloudinary.com/dh78qytaz/image/upload/d_default_photo/v1607589287/default_photo.png"
  end
end
