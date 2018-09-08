def assign_employee_rate(item)
  item.hourly_rate = Faker::Number.decimal(2, 2) if item.agreement_contract?
  item.monthly_rate = Faker::Number.decimal(5, 2) if item.employment_contract?
  item
end

100.times do
  e = Employee.new
  e.first_name = Faker::LordOfTheRings.character
  e.last_name = Faker::Name.last_name
  e.address = Faker::LordOfTheRings.location
  e.contract_type = Enums::ContractTypes.values.sample
  assign_employee_rate(e)
  e.save
end
