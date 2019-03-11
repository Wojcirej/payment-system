require 'rails_helper'

RSpec.describe Api::UserSerializer do
  subject { described_class.new(user) }
  let(:user) { build(:user) }
  let(:expected_keys) { %i(id username email) }

  include_examples "serialization"
end
