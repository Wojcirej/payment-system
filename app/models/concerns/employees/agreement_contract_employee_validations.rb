module Employees::AgreementContractEmployeeValidations
  extend ActiveSupport::Concern

  included do
    validates :hourly_rate,
      presence: { message: "Employee on agreement contract must have specified hourly rate." },
      if: :agreement_contract?
    validates :monthly_rate, absence: true, if: :agreement_contract?
  end
end
