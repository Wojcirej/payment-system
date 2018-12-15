require 'rails_helper'

RSpec.describe EmployeeCreator do
  subject { described_class.call(params) }

  describe "#call" do

    context "when 'contract agreement' present in params" do
      let(:params) { { contract_type: "contract agreement" } }

      it "delegates to Employees::OnAgreementCreator class" do
        expect_any_instance_of(Employees::OnAgreementCreator).to receive(:save)
        subject
      end
    end

    context "when 'contract of employment' present in params" do
      let(:params) { { contract_type: "contract of employment" } }

      it "delegates to Employees::OnEmploymentCreator class" do
        expect_any_instance_of(Employees::OnEmploymentCreator).to receive(:save)
        subject
      end
    end

    context "when not recognized contract type in params" do
      let(:params) { {} }

      it "delegates to Employees::Creator class" do
        expect_any_instance_of(Employees::Creator).to receive(:save)
        subject
      end
    end
  end
end
