require 'rails_helper'

RSpec.describe Employees::Creators::OnEmploymentCreator do
  subject { described_class.call(params) }

  describe "#call" do

    context "when valid params" do
      let(:params) { build(:employee, :employment_contract).attributes.with_indifferent_access }

      include_examples "Employee created"

      it "assigns 'contract_type' as 'contract of employment'" do
        expect(subject.contract_type).to eq("contract of employment")
      end

      it "assigns 'monthly_rate' as in params" do
        expect(subject.monthly_rate).to eq(params[:monthly_rate])
      end

      it "assigns 'hourly_rate' empty" do
        expect(subject.hourly_rate).to be_nil
      end
    end

    context "when invalid params" do
      let(:params) { {} }

      include_examples "Employee not created"
    end
  end
end
