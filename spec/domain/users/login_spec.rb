require 'rails_helper'

RSpec.describe Users::Login do
  subject { described_class.call(credentials) }

  describe "#call" do

    context "when no user with specified username" do
      let(:credentials) { { username: "nonexistent", password: "nonexistent" } }

      it "does not encode token for user" do
        expect(JsonWebToken).not_to receive(:encode)
        subject
      end

      it "returns not persisted user object" do
        expect(subject.persisted?).to be false
      end

      it "returns user object with specified username" do
        expect(subject.username).to eq(credentials[:username])
      end

      it "returns user object without token" do
        expect(subject.current_token).to be nil
      end
    end

    context "when user with specified username exists" do
      let(:user) { create(:user) }

      context "when invalid credentials" do
        let(:credentials) { { username: user.username, password: "invalid" } }

        it "does not encode token for user" do
          expect(JsonWebToken).not_to receive(:encode)
          subject
        end

        it "returns persisted user object" do
          expect(subject.persisted?).to be true
        end

        it "returns user object with specified username" do
          expect(subject.username).to eq(credentials[:username])
        end

        it "returns user object without token" do
          expect(subject.current_token).to be nil
        end
      end

      context "when valid credentials" do
        let(:credentials) { { username: user.username, password: user.password } }

        it "returns persisted user object" do
          expect(subject.persisted?).to be true
        end

        it "returns user object with specified username" do
          expect(subject.username).to eq(credentials[:username])
        end

        it "encodes token for user" do
          expect(JsonWebToken).to receive(:encode).with({ user_id: user.id })
          subject
        end

        it "returns user object with token" do
          expect(subject.current_token).to be_present
        end
      end
    end
  end
end
