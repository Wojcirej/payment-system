FactoryBot.define do
  factory :employee do
    first_name { Faker::LordOfTheRings.character }
    last_name { Faker::LordOfTheRings.character }
    address { Faker::LordOfTheRings.location }
    contract_type "contract agreement"
    provision 0
  end

  trait :employment_contract do
    contract_type "contract of employment"
    monthly_rate 3391
    hourly_rate nil
  end

  trait :agreement_contract do
    contract_type "contract agreement"
    hourly_rate 13.70
    monthly_rate nil
  end
end
