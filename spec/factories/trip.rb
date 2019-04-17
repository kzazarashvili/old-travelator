FactoryBot.define do
  factory :trip do
    user
    started_at { Date.yesterday }
    ended_at { Date.today }

    trait :invalid do
      started_at { nil }
    end

    trait :new do
      ended_at { nil }
    end
  end
end
