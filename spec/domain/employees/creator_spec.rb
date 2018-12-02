require 'rails_helper'

RSpec.describe Employees::Creator do
  subject { described_class.new(params) }

  describe "#save" do

    context "when valid params" do
      let(:params) { build(:employee).attributes.with_indifferent_access }

      include_examples "Employee created"
    end

    context "when invalid params" do
      let(:params) { {} }

      include_examples "Employee not created"
    end
  end
end
