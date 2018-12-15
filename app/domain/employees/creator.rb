module Employees
  class Creator
    include ActiveModel::Model
    include Employees::BaseValidations
    include Employees::ContractMethods

    attr_accessor :first_name, :last_name, :address, :contract_type, :hourly_rate,
    :monthly_rate, :provision

    def initialize(params = {})
      @first_name = params[:first_name]
      @last_name = params[:last_name]
      @address = params[:address]
      @contract_type = params[:contract_type]
      @hourly_rate = params[:hourly_rate]
      @monthly_rate = params[:monthly_rate]
      @provision = params[:provision]
    end

    def save
      return Employee.create(
        first_name: first_name,
        last_name: last_name,
        address: address,
        contract_type: contract_type,
        hourly_rate: hourly_rate,
        monthly_rate: monthly_rate,
        provision: provision
      )
    end
  end
end
