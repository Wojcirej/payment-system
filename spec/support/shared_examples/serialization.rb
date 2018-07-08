RSpec.shared_examples "serialization" do

  context "when successful response" do

    it "has all expected keys in response data" do
      expect(subject.serializable_hash.keys).to match_array(expected_keys)
    end
  end

  context "when not successful response" do

    before do
      allow(subject.object).to receive_message_chain('errors.present?').and_return(true)
    end

    it 'has errors keys in response' do
      expect(subject.serializable_hash.keys).to include(*[:errors, :error_messages])
    end
  end
end
