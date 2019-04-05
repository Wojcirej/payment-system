require 'spec_config'

RSpec.describe JsonWebToken do
  subject { described_class }

  describe ".encode" do
    let(:payload) { { "foo" => "bar" } }

    it "returns token as a String" do
      expect(subject.encode(payload)).to be_kind_of(String)
    end

    context "when expiration time not present" do

      before do
        Timecop.freeze(Time.current)
      end

      after do
        Timecop.return
      end

      it "returns token valid for 24 hours from the moment of creation" do
        token = subject.encode(payload)
        expect(Time.at(subject.decode(token)[:exp]).utc.to_s).to eq((Time.current + 24.hours).utc.to_s)
      end
    end
  end

  describe ".decode" do

    context "when token decoded successfully" do
      let(:token) { subject.encode({ foo: "bar" }) }

      it "returns Hash" do
        expect(subject.decode(token)).to be_kind_of(Hash)
      end

      it "returns Hash with original payload keys and expiration time" do
        expect(subject.decode(token).keys).to eq(%w(foo exp))
      end
    end

    context "when token not decoded successfully" do
      let(:token) { "eyJhbGciOiJIUzI1NiJ9.eyJmb28iOiJiYXIiLCJleHAiOjE1NTIwNzMxMzR9.s5G8XSOWQ4l6YP3jD7KLcbb0RB29eTN5pU49l-6sKKs" }

      it "returns Hash" do
        expect(subject.decode(token)).to be_kind_of(Hash)
      end

      it "returns Hash with error type and error message" do
        expect(subject.decode(token).keys).to eq(%w(error message))
      end

      context "when decoding failed due expired signature" do

        it "returns 'JWT::ExpiredSignature' error type" do
          expect(subject.decode(token)[:error]).to be JWT::ExpiredSignature
        end

        it "returns error message about signature expired" do
          expect(subject.decode(token)[:message]).to eq("Signature has expired")
        end
      end

      context "when decoding failed due incorrect token" do
        let(:token) { "incorrecttoken" }

        it "returns 'JWT::DecodeError' error type" do
          expect(subject.decode(token)[:error]).to be JWT::DecodeError
        end

        it "returns error message about invalid segments" do
          expect(subject.decode(token)[:message]).to eql("Not enough or too many segments")
        end
      end
    end
  end
end
