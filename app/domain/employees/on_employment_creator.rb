class Employees::OnEmploymentCreator < Employees::Creator
  include Employees::EmploymentContractEmployeeValidations

  def initialize(params = {})
    super(params)
  end

  def save
    return Employee.create(
      first_name: first_name,
      last_name: last_name,
      address: address,
      contract_type: contract_type,
      monthly_rate: monthly_rate,
      provision: provision
    )
  end
end
