# frozen_string_literal: true

module FlipperMigration
  class FlipperFeature < ApplicationRecord
    has_many :flipper_gates, dependent: :destroy,
                             foreign_key: :feature_key,
                             primary_key: :key
  end

  class FlipperGate < ApplicationRecord
  end

  def create_flag!(flag_key)
    FlipperFeature.find_or_create_by! key: flag_key
  end

  def destroy_flag(flag_key)
    FlipperFeature.find_by!(key: flag_key)&.destroy
  end
end
