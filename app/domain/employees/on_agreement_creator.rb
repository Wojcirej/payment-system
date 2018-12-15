class Employees::OnAgreementCreator < Employees::Creator
  include Employees::AgreementContractEmployeeValidations

  def initialize(params = {})
    super(params)
  end

  def save
    return Employee.create(
      first_name: first_name,
      last_name: last_name,
      address: address,
      contract_type: contract_type,
      hourly_rate: hourly_rate,
      provision: provision
    )
  end
end
