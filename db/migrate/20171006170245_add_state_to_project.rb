class AddStateToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :state, :string, null: false, default: 'newed'
  end
end
