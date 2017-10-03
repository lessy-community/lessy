class RenameProjectStoppedAtInPausedAt < ActiveRecord::Migration[5.1]
  def change
    rename_column :projects, :stopped_at, :paused_at
  end
end
