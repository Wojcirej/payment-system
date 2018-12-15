require 'rails_helper'

RSpec.describe Employees::OnEmploymentCreator do
  subject { described_class.new(params) }

  describe "#save" do

    context "when valid params" do
      let(:params) { build(:employee, :employment_contract).attributes.with_indifferent_access }

      include_examples "Employee created"

      it "assigns 'contract_type' as 'contract of employment'" do
        record = subject.save
        expect(record.contract_type).to eq("contract of employment")
      end

      it "assigns 'monthly_rate' as in params" do
        record = subject.save
        expect(record.monthly_rate).to eq(params[:monthly_rate])
      end

      it "assigns 'hourly_rate' empty" do
        record = subject.save
        expect(record.hourly_rate).to be_nil
      end
    end

    context "when invalid params" do
      let(:params) { {} }

      include_examples "Employee not created"
    end
  end
end
