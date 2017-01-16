class AddStoppedAtToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :stopped_at, :datetime
  end
end
