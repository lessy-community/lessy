class AddIndexOnProjectName < ActiveRecord::Migration[5.0]
  def change
    add_index :projects, 'name'
    add_index :projects, ['name', 'user_id'], unique: true
  end
end
