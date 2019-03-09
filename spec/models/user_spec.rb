require 'rails_helper'

RSpec.describe User, type: :model do

  it "has valid factory" do
    expect(build(:user)).to be_valid
  end

  it "has secure password" do
    create(:user)
    expect(User.last.password).not_to eq("MyString")
  end

  describe "columns" do
    it { is_expected.to have_db_column(:username).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:password_digest).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:current_token).of_type(:string) }
  end

  describe "validations" do
    let(:user) { create(:user) }
    it { is_expected.to validate_presence_of(:username).with_message("Please specify username.") }
    it { expect(user).to validate_uniqueness_of(:username).with_message("User with specified username exists.") }
    it { is_expected.to validate_presence_of(:password).with_message("Please specify your password.") }
    it { is_expected.to validate_presence_of(:email).with_message("Please specify email address.") }
    it { expect(user).to validate_uniqueness_of(:email).with_message("User with specified email address exists.") }
    it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(20).with_message("Your password should have at least 8 characters and at most 20 characters.") }
  end

  describe "indexes" do
    it { is_expected.to have_db_index(:email).unique(true) }
    it { is_expected.to have_db_index(:username).unique(true) }
  end
end
