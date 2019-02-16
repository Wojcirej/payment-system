class Employee < ApplicationRecord
  include Employees::BaseValidations
  include Employees::AgreementContractEmployeeValidations
  include Employees::EmploymentContractEmployeeValidations
  include Employees::ContractMethods

  default_scope -> { order("created_at ASC") }
end
