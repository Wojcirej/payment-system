require 'spec_config'

RSpec.describe Api::EmployeeSerializer do
  subject { described_class.new(employee) }
  let(:employee) { build(:employee) }
  let(:expected_keys) { %i(id first_name last_name address contract_type salary provision) }

  include_examples "serialization"

  context "when it is employee on 'contract of employment'" do
    let(:employee) { build(:employee, :employment_contract) }

    it "serializes monthly rate under 'salary' key" do
      expect(subject.serializable_hash[:salary]).to eql(sprintf("%.2f", employee.monthly_rate))
    end
  end

  context "when it is employee on 'contract agreement'" do
    let(:employee) { build(:employee, :agreement_contract) }

    it "serializes hourly rate under 'salary' key" do
      expect(subject.serializable_hash[:salary]).to eql(sprintf("%.2f", employee.hourly_rate))
    end
  end
end
