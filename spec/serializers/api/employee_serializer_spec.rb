require 'rails_helper'

RSpec.describe Api::EmployeeSerializer do
  subject { described_class.new(employee) }
  let(:employee) { build(:employee) }
  let(:expected_keys) { %i(id first_name last_name address contract_type salary provision) }

  include_examples "serialization"

  context "when it is employee on 'contract of employment'" do
    let(:employee) { build(:employee, :employment_contract) }

    it "serializes monthly rate under 'salary' key" do
      expect(subject.serializable_hash[:salary]).to eql(employee.monthly_rate.to_f)
    end
  end

  context "when it is employee on 'contract agreement'" do
    let(:employee) { build(:employee, :contract_agreement) }

    it "serializes hourly rate under 'salary' key" do
      expect(subject.serializable_hash[:salary]).to eql(employee.hourly_rate.to_f)
    end
  end
end