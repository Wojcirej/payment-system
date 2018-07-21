class Api::EmployeeSerializer < Api::BaseSerializer
  include ActionView::Helpers::NumberHelper
  attributes :id, :first_name, :last_name, :address, :contract_type, :salary,
  :provision

  def salary
    salary = object.monthly_rate if object.contract_type == "contract of employment"
    salary = object.hourly_rate if object.contract_type == "contract agreement"
    return number_with_precision(salary, precision: 2)
  end

  def provision
    number_with_precision(object.provision, precision: 2)
  end
end
