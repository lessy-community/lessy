# frozen_string_literal: true

class TermsOfService < ApplicationRecord
  validates :content, :version, :effective_at, presence: true
  validates :version, uniqueness: { case_sensitive: false }

  def self.current
    TermsOfService
      .where('effective_at <= ?', Time.zone.now)
      .order(:effective_at)
      .last
  end
end
