class AddAbandonedAtToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :abandoned_at, :datetime
  end
end
