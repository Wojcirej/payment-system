class Api::EmployeesController < ApplicationController
  before_action :set_employee, only: :show

  def index
    render json: Employee.all, status: :ok, each_serializer: Api::EmployeeSerializer
  end

  def show
    render json: @employee, status: :ok, serializer: Api::EmployeeSerializer
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end
end
