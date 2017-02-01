class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :label, null: false
      t.datetime :due_at
      t.datetime :finished_at
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
