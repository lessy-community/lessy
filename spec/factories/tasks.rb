FactoryGirl.define do
  factory :task do
    label "My task"
    user
    sequence :order

    trait :finished do
      finished_at { 15.days.ago }
    end

    trait :not_finished do
      finished_at nil
    end

    trait :abandoned do
      abandoned_at { 15.days.ago }
    end

    trait :not_abandoned do
      abandoned_at nil
    end

    trait :pending do
      due_at { 1.day.ago }
      finished_at nil
    end

    trait :backlogged do
      due_at nil
      finished_at nil
    end
  end
end
