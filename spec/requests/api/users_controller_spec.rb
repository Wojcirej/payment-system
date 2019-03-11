require 'rails_helper'

RSpec.describe Api::UsersController, type: :request do
  let(:base_url) { "/api/users" }
  let(:number_of_json_keys) { 3 }

  describe "POST /api/employees" do
    let(:path) { base_url }

    before do
      post path, params: params.to_json
    end

    context "when valid request params" do
      let(:params) do
        {
          "username": "testUser",
          "password": "12345678",
          "password_confirmation": "12345678",
          "email": "test@user.com",
        }
      end

      it "responds with HTTP 201 status" do
        expect(response.status).to eq(201)
      end

      it "responds with created user" do
        expect(data['username']).to eql(params[:username])
      end

      it "responds with serialized user" do
        expect(data.size).to eql(number_of_json_keys)
      end

      it "does not respond with errors" do
        expect(errors).to be_blank
      end
    end

    context "when invalid request params" do
      let(:params) { {} }

      it "responds with HTTP 422 status" do
        expect(response.status).to eq(422)
      end

      it "responds with errors" do
        aggregate_failures "errors response" do
          expect(errors).to be_present
          expect(errors['username']).to include("Please specify username.")
          expect(errors['password']).to include("Please specify your password.")
          expect(errors['password']).to include("Your password should have at least 8 characters and at most 20 characters.")
          expect(errors['email']).to include("Please specify email address.")
        end
      end

      it "responds with error messages" do
        expect(error_messages.size).to eq(5)
      end
    end
  end
end
