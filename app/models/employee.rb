class Employee < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates_inclusion_of :contract_type, in: Enums::ContractTypes::values
  validates_numericality_of :hourly_rate, greater_than_or_equal_to: 13.70, allow_nil: true
  validates_numericality_of :monthly_rate, greater_than_or_equal_to: 2100.00, allow_nil: true
  validates_numericality_of :provision, greater_than_or_equal_to: 0
end
