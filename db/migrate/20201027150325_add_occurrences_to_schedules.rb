class AddOccurrencesToSchedules < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :occurrences, :string, array: true, default: []
  end
end
