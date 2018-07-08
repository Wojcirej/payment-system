class Api::EmployeeSerializer < Api::BaseSerializer
  attributes :id, :first_name, :last_name, :address, :contract_type, :salary,
  :provision

  def salary
    return object.monthly_rate.to_f if object.contract_type == "contract of employment"
    return object.hourly_rate.to_f if object.contract_type == "contract agreement"
  end

  def provision
    object.provision.to_f
  end
end
