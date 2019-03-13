require 'rails_helper'

RSpec.describe Api::Users::LoginSuccessSerializer do
  subject { described_class.new(user) }
  let(:user) { build(:user) }
  let(:expected_keys) { %i(id username email current_token message) }

  include_examples "serialization"
end
