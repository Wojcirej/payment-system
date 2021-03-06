require 'spec_config'

RSpec.describe Api::Users::LoginSuccessSerializer do
  subject { described_class.new(user) }
  let(:user) { build(:user) }
  let(:expected_keys) { %i(id username email message) }

  include_examples "serialization"
end
