require 'rails_helper'

RSpec.describe Employees::Creator do
  subject { described_class.call(params) }

  describe "#call" do

    context "when 'contract agreement' present in params" do
      let(:params) { { contract_type: "contract agreement" } }

      it "delegates to Employees::Creators::OnAgreementCreator class" do
        expect(Employees::Creators::OnAgreementCreator).to receive(:call)
        subject
      end
    end

    context "when 'contract of employment' present in params" do
      let(:params) { { contract_type: "contract of employment" } }

      it "delegates to Employees::Creators::OnEmploymentCreator class" do
        expect(Employees::Creators::OnEmploymentCreator).to receive(:call)
        subject
      end
    end

    context "when not recognized contract type in params" do
      let(:params) { {} }

      it "delegates to Employees::Creators::Null class" do
        expect(Employees::Creators::Null).to receive(:call)
        subject
      end
    end
  end
end
