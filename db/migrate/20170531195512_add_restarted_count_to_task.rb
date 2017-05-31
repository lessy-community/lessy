class AddRestartedCountToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :restarted_count, :integer, null: false, default: 0
  end
end
