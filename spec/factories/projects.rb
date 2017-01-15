FactoryGirl.define do
  factory :project do
    sequence(:name, 'a') { |n| "my-project-#{ n }" }
    user

    trait :in_progress do
      started_at { 15.days.ago }
      due_at { 15.days.from_now }
    end

    trait :finished do
      started_at { 30.days.ago }
      due_at { 15.days.ago }
    end
  end
end
