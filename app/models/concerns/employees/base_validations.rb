module Employees::BaseValidations
  extend ActiveSupport::Concern

  included do
    validates :first_name, presence: { message: "Please specify employee's first name." }
    validates :last_name, presence: { message: "Please specify employee's last name." }
    validates_inclusion_of :contract_type, in: Enums::ContractTypes::values,
    message: "Not supported type of contract."
    validates_numericality_of :hourly_rate, greater_than_or_equal_to: 13.70, allow_nil: true
    validates_numericality_of :monthly_rate, greater_than_or_equal_to: 2100.00, allow_nil: true
    validates_numericality_of :provision, greater_than_or_equal_to: 0,
    message: "Provision must not be negative."
  end
end
