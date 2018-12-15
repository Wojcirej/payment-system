class EmployeeCreator

  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def self.call(params = {})
    new(params).call
  end

  def call
    creator = select_creator[params[:contract_type]] || Employees::Creator
    return creator.new(params).save
  end

  private

  def select_creator
    {
      "contract of employment" => Employees::OnEmploymentCreator,
      "contract agreement" => Employees::OnAgreementCreator
    }
  end
end
