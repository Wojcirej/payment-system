require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject { create(:employee) }
  let(:permissible_contract_types) { Enums::ContractTypes::values }

  it "has valid factory" do
    expect(build(:employee)).to be_valid
  end

  describe "columns" do
    it { expect(subject).to have_db_column(:first_name).of_type(:string).with_options(null: false) }
    it { expect(subject).to have_db_column(:last_name).of_type(:string).with_options(null: false) }
    it { expect(subject).to have_db_column(:address).of_type(:string) }
    it { expect(subject).to have_db_column(:contract_type).of_type(:string).with_options(null: false) }
    it { expect(subject).to have_db_column(:hourly_rate).of_type(:decimal).with_options(scale: 2, precision: 10) }
    it { expect(subject).to have_db_column(:monthly_rate).of_type(:decimal).with_options(scale: 2, precision: 10) }
    it { expect(subject).to have_db_column(:provision).of_type(:decimal).with_options(null: false, default: 0.00, scale: 2, precision: 10) }
  end

  describe "validations" do
    it { expect(subject).to validate_presence_of(:first_name).with_message("Please specify employee's first name.") }
    it { expect(subject).to validate_presence_of(:last_name).with_message("Please specify employee's last name.") }
    it { expect(subject).to validate_inclusion_of(:contract_type).in_array(permissible_contract_types).with_message("Not supported type of contract.") }
    it { expect(subject).to validate_numericality_of(:hourly_rate).is_greater_than_or_equal_to(13.70) }
    it { expect(subject).to validate_numericality_of(:monthly_rate).is_greater_than_or_equal_to(2100.00) }
    it { expect(subject).to validate_numericality_of(:provision).is_greater_than_or_equal_to(0).with_message("Provision must not be negative.") }

    context "when it is employee on agreement contract" do
      let(:employee) { create(:employee, :agreement_contract) }

      it { expect(employee).to validate_absence_of(:monthly_rate) }
      it { expect(employee).to validate_presence_of(:hourly_rate).with_message("Employee on agreement contract must have specified hourly rate.") }
    end

    context "when it is employee on contract of employment" do
      let(:employee) { create(:employee, :employment_contract) }

      it { expect(employee).to validate_absence_of(:hourly_rate) }
      it { expect(employee).to validate_presence_of(:monthly_rate).with_message("Employee on contract of employment must have specified monthly rate.") }
    end
  end
end
