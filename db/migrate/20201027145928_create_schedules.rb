class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :year
      t.integer :month

      t.timestamps
    end
  end
end
