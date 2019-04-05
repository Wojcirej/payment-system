require 'spec_config'

RSpec.describe Api::Users::LoginFailureSerializer do
  subject { described_class.new(user) }
  let(:user) { build(:user) }
  let(:expected_keys) { %i(username message) }

  include_examples "serialization"
end
