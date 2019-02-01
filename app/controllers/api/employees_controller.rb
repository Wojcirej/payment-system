class Api::EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :destroy]

  def index
    render json: Employee.all, status: :ok, each_serializer: Api::EmployeeSerializer
  end

  def show
    render json: @employee, status: :ok, serializer: Api::EmployeeSerializer
  end

  def create
    @employee = Employees::Creator.call(employee_params)
    status = @employee.persisted? ? :created : :unprocessable_entity
    render json: @employee, status: status, serializer: Api::EmployeeSerializer
  end

  def destroy
    @employee.destroy
    response_object = if @employee.destroyed?
      { json: @employee, status: 200, serializer: Api::EmployeeSerializer }
    else
      { json: { message: "Couldn't delete Employee with 'id'=#{@employee.id}" }, status: 422 }
    end
    render response_object
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params = ActionController::Parameters.new(json)
    params.permit(:first_name, :last_name, :address, :contract_type, :hourly_rate,
    :monthly_rate, :provision)
  end
end
