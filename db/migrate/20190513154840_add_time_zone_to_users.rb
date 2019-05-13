# frozen_string_literal: true

class AddTimeZoneToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :time_zone, :string, default: 'UTC'
  end
end
