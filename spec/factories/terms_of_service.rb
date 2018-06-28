# frozen_string_literal: true

FactoryBot.define do
  factory :terms_of_service do
    content 'ToS content'
    sequence(:version) { |i| "2018-#{i}" }
    effective_at { 1.day.ago }

    trait :in_the_past do
      effective_at { 1.month.ago }
    end

    trait :in_the_future do
      effective_at { 1.month.from_now }
    end
  end
end
