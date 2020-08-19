class AddBookingStepToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :booking_step, :integer
  end
end
