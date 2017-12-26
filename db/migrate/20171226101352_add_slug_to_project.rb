class AddSlugToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :slug, :string
    Project.update_all 'slug = name'
    change_column_null :projects, :slug, false
  end
end
