# frozen_string_literal: true

class FlipperGate < ApplicationRecord
  belongs_to :flipper_feature, foreign_key: :feature_key,
                               primary_key: :key,
                               inverse_of: :flipper_gate
end
