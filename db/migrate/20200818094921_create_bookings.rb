class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.string :task
      t.date :date
      t.time :start_time
      t.time :end_time
      t.text :comment
      t.string :status
      t.references :helper, null: false, foreign_key: { to_table: 'users' }
      t.references :senior, null: false, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
