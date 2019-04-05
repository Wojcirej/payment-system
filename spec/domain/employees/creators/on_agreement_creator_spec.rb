require 'spec_config'

RSpec.describe Employees::Creators::OnAgreementCreator do
  subject { described_class.call(params) }

  describe "#call" do

    context "when valid params" do
      let(:params) { build(:employee, :agreement_contract).attributes.with_indifferent_access }

      include_examples "Employee created"

      it "assigns 'contract_type' as 'contract agreement'" do
        expect(subject.contract_type).to eq("contract agreement")
      end

      it "assigns 'hourly_rate' as in params" do
        expect(subject.hourly_rate).to eq(params[:hourly_rate])
      end

      it "assigns 'monthly_rate' empty" do
        expect(subject.monthly_rate).to be_nil
      end
    end

    context "when invalid params" do
      let(:params) { {} }

      include_examples "Employee not created"
    end
  end
end
