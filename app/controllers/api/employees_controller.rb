class Api::EmployeesController < ApplicationController

  def index
    render json: Employee.all, status: 200, each_serializer: Api::EmployeeSerializer
  end
end
