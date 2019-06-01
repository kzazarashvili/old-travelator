FactoryBot.define do
  factory :country do
    name { 'Poland' }
    abbreviation { 'Pl' }

    trait :valid_country do
      name { 'Georgia' }
      abbreviation { 'Ge' }
    end

    trait :invalid_country do
      name { nil }
      abbreviation { nil }
    end

    trait :new_name do
      name { 'Germany' }
    end
  end
end
