FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "john+#{ n }@doe.com" }

    trait :activated do
      after(:create) do |user|
        user.activate!
      end
    end
  end
end
