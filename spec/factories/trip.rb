FactoryBot.define do
  factory :trip do
    user
    started_at { Date.yesterday }
    ended_at { Date.today }
  end
end
