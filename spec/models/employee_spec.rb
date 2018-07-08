require 'rails_helper'

RSpec.describe Employee, type: :model do
  subject { create(:employee, :contract_agreement) }
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
    it { expect(subject).to have_db_column(:provision).of_type(:decimal).with_options(scale: 2, precision: 10) }
  end

  describe "validations" do
    it { expect(subject).to validate_presence_of(:first_name) }
    it { expect(subject).to validate_presence_of(:last_name) }
    it { expect(subject).to validate_inclusion_of(:contract_type).in_array(permissible_contract_types) }
    it { expect(subject).to validate_numericality_of(:hourly_rate).is_greater_than_or_equal_to(13.70) }
    it { expect(subject).to validate_numericality_of(:monthly_rate).is_greater_than_or_equal_to(2100.00) }
    it { expect(subject).to validate_numericality_of(:provision).is_greater_than_or_equal_to(0) }
  end
end
