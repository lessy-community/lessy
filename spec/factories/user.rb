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

    trait :password_reseted do
      after(:create, &:generate_reset_password_token!)
    end

    trait :not_accepted_tos do
      terms_of_service { nil }
    end
  end
end
