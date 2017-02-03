FactoryGirl.define do
  factory :task do
    label "My task"
    user

    trait :finished do
      finished_at { 15.days.ago }
    end

    trait :not_finished do
      finished_at nil
    end
  end
end
