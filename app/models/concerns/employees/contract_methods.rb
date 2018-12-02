module Employees::ContractMethods
  extend ActiveSupport::Concern

  def employment_contract?
    contract_type == "contract of employment"
  end

  def agreement_contract?
    contract_type == "contract agreement"
  end
end
