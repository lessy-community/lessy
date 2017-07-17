class AddProjectReferencesToTask < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasks, :project, foreign_key: true, null: true
  end
end
