FactoryGirl.define do
  factory :project, traits: [:newed] do
    sequence(:name, 'a') { |n| "my-project-#{ n }" }
    user

    after(:build) do |project|
      project.slug = project.name
    end

    trait :newed do
      state 'newed'
      started_at nil
      paused_at nil
      due_at nil
      finished_at nil
    end

    trait :started do
      state 'started'
      started_at { 15.days.ago }
      paused_at nil
      due_at { 15.days.from_now }
      finished_at nil
    end

    trait :paused do
      state 'paused'
      started_at { 30.days.ago }
      paused_at { 15.days.ago }
      due_at { 15.days.from_now }
      finished_at nil
    end

    trait :finished do
      state 'finished'
      started_at { 30.days.ago }
      paused_at nil
      due_at { 15.days.ago }
      finished_at { 15.days.ago }
    end
  end
end
