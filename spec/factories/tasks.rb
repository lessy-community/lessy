FactoryBot.define do
  factory :task, traits: [:newed] do
    label { 'My task' }
    user
    sequence :order

    trait :newed do
      state { 'newed' }
      started_at { nil }
      planned_at { nil }
      finished_at { nil }
      abandoned_at { nil }
    end

    trait :started do
      state { 'started' }
      started_at { 15.days.ago }
      planned_at { nil }
      finished_at { nil }
      abandoned_at { nil }
    end

    trait :planned do
      state { 'planned' }
      started_at { 15.days.ago }
      planned_at { 15.days.from_now }
      finished_at { nil }
      abandoned_at { nil }
    end

    trait :finished do
      state { 'finished' }
      planned_at { 15.days.ago }
      finished_at { 5.days.ago }
      abandoned_at { nil }
    end

    trait :abandoned do
      state { 'abandoned' }
      finished_at { nil }
      abandoned_at { 5.days.ago }
    end
  end
end
