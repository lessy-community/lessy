FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "john+#{ n }@doe.com" }
    sequence(:username, 'a') { |n| "john_#{ n }" }

    trait :activated do
      after(:create) do |user|
        user.activate!
      end
    end

    trait :inactive do
      # nothing on purpose
    end
  end
end
