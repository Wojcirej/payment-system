class Employees::Creators::OnAgreementCreator

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def self.call(params)
    new(params).call
  end

  def call
    return Employee.create(params)
  end
end
