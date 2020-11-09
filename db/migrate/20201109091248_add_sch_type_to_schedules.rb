class AddSchTypeToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :sch_type, :string
  end
end
