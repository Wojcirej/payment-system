module Employees::EmploymentContractEmployeeValidations
  extend ActiveSupport::Concern

  included do
    validates :monthly_rate,
      presence: { message: "Employee on contract of employment must have specified monthly rate." },
      if: :employment_contract?
    validates :hourly_rate, absence: true, if: :employment_contract?
  end
end
