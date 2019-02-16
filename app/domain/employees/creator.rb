class Employees::Creator
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def self.call(params = {})
    new(params).call
  end

  def call
    creator = select_creator[params[:contract_type]] || Employees::Creators::Null
    return creator.call(params)
  end

  private

  def select_creator
    {
      "contract of employment" => Employees::Creators::OnEmploymentCreator,
      "contract agreement" => Employees::Creators::OnAgreementCreator
    }
  end
end
