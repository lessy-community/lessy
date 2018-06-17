# frozen_string_literal: true

class FlipperFeature < ApplicationRecord
  has_many :flipper_gates, dependent: :destroy,
                           foreign_key: :feature_key,
                           primary_key: :key,
                           inverse_of: :flipper_feature
end
