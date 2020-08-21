class DeleteTaskFromBookings < ActiveRecord::Migration[6.0]
  def change
    remove_column :bookings, :task, :string
  end
end
