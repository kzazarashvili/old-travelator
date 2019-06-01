FactoryBot.define do
  factory :country do
    name { 'Poland' }
    abbreviation { 'Pl' }

    trait :valid do
      name { 'Georgia' }
      abbreviation { 'Ge' }
    end

    trait :invalid do
      name { nil }
      abbreviation { nil }
    end

    trait :new_name do
      name { 'Germany' }
    end
  end
end
