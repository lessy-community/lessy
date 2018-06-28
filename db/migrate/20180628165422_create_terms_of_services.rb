# frozen_string_literal: true

class CreateTermsOfServices < ActiveRecord::Migration[5.1]
  def change
    create_table :terms_of_services do |t|
      t.text :content, null: false
      t.string :version, null: false
      t.datetime :effective_at, null: false

      t.timestamps
    end
  end
end
