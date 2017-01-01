FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "john+#{ n }@doe.com" }
  end
end
