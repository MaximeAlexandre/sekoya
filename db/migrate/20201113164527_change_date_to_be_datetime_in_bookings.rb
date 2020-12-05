class ChangeDateToBeDatetimeInBookings < ActiveRecord::Migration[6.0]
  def up
    change_column :bookings, :date, :datetime
  end

  def down
    change_column :bookings, :date, :date
  end
end
