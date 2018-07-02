# frozen_string_literal: true

class AddTermsOfServiceReferenceToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :terms_of_service, foreign_key: true, null: true
  end
end
