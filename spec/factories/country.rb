FactoryBot.define do
  factory :country do
    name { 'Poland' }
    abbreviation { 'Pl' }

    trait :valid_name do
      name { 'Georgia' }
    end

    trait :invalid_name do
      name { nil }
    end

    trait :new_name do
      name { 'Germany' }
    end
  end
end
