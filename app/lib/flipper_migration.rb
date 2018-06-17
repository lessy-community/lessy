# frozen_string_literal: true

module FlipperMigration
  class FlipperFeature < ApplicationRecord
    has_many :flipper_gates, dependent: :destroy,
                             foreign_key: :feature_key,
                             primary_key: :key
  end

  class FlipperGate < ApplicationRecord
  end

  def create_flag(flag_key, enabled: false)
    if enabled
      Flipper.enable flag_key
    else
      Flipper.disable flag_key
    end
  end

  def destroy_flag(flag_key)
    FlipperFeature.find_by!(key: flag_key)&.destroy
  end
end
