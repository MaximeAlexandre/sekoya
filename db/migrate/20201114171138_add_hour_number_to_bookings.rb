class AddHourNumberToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :hour_number, :integer
  end
end
