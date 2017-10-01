class RenameTasksRestartedCountInStartedCount < ActiveRecord::Migration[5.1]
  class Task < ApplicationRecord
  end

  def change
    rename_column :tasks, :restarted_count, :started_count
    Task.update_all('started_count = started_count + 1')
  end
end
