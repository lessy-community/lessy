class AddOrderToTask < ActiveRecord::Migration[5.0]
  class Task < ApplicationRecord
  end

  def up
    add_column :tasks, :order, :integer, null: true

    Task.transaction do
      User.all.each do |user|
        user.tasks.order(:due_at, :label).each_with_index do |task, index|
          task.update! order: (index + 1)
        end
      end
    end

    change_column_null :tasks, :order, null: false
    add_index :tasks, :order
  end

  def down
    remove_column :tasks, :order
  end
end
