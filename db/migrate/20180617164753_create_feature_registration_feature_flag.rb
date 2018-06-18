# frozen_string_literal: true

class CreateFeatureRegistrationFeatureFlag < ActiveRecord::Migration[5.1]
  include FlipperMigration

  def up
    create_flag :feature_registration, enabled: true
  end

  def down
    destroy_flag :feature_registration
  end
end
