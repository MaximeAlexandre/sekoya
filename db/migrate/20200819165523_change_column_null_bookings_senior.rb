class ChangeColumnNullBookingsSenior < ActiveRecord::Migration[6.0]
  def change
    change_column_null :bookings, :senior_id, true
  end
end
