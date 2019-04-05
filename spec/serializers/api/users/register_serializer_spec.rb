require 'spec_config'

RSpec.describe Api::Users::RegisterSerializer do
  subject { described_class.new(user) }
  let(:user) { build(:user) }
  let(:expected_keys) { %i(id username email) }

  include_examples "serialization"
end
