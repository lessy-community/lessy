class AddFinishedAtToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :finished_at, :datetime
  end
end
