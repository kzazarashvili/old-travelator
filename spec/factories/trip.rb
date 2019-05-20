FactoryBot.define do
  factory :trip do
    user
    started_at { Date.today - 10 }
    ended_at { Date.today - 7 }

    trait :invalid do
      started_at { nil }
    end

    trait :new do
      ended_at { nil }
    end

    trait :start_date_taken do
      started_at { Date.today - 10 }
      ended_at { Date.today }
    end

    trait :start_date_in_taken_range do
      started_at { Date.today - 8 }
      ended_at { Date.today }
    end

    trait :days_inside_included_in_taken_range do
      started_at { Date.today - 11 }
      ended_at { Date.today }
    end

    trait :start_date_match_with_previous_end_date do
      started_at { Date.today - 7 }
    end
  end
end
