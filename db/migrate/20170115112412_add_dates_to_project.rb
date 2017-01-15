class AddDatesToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :started_at, :datetime
    add_column :projects, :due_at, :datetime
  end
end
