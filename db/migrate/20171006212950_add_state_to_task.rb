class AddStateToTask < ActiveRecord::Migration[5.1]
  class Task < ApplicationRecord
  end

  def up
    add_column :tasks, :state, :string, null: false, default: 'newed'
    add_column :tasks, :started_at, :datetime
    rename_column :tasks, :due_at, :planned_at
    rename_column :tasks, :started_count, :planned_count

    Task.update_all "started_at = created_at"
    Task.where(planned_at: nil).update_all state: 'started'
    Task.where.not(planned_at: nil).update_all state: 'planned'
  end

  def down
    rename_column :tasks, :planned_count, :started_count
    rename_column :tasks, :planned_at, :due_at
    remove_column :tasks, :started_at
    remove_column :tasks, :state
  end
end
