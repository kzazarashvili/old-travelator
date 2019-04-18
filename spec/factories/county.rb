FactoryBot.define do
  factory :country do
    name { 'some name' }

    trait :invalid_name do
      name { nil }
    end
  end
end
