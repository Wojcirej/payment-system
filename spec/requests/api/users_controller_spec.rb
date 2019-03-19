require 'rails_helper'

RSpec.describe Api::UsersController, type: :request do
  let(:base_url) { "/api/users" }
  let(:number_of_json_keys) { 3 }

  describe "POST /api/users" do
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

  describe "POST /api/users/login" do

    shared_examples "invalid credentials" do

      it "responds with HTTP 401 status" do
        expect(response.status).to eq(401)
      end

      it "responds with message about incorrect password" do
        expect(data['message']).to eq("Incorrect credentials, please try again.")
      end

      it "responds with specified username" do
        expect(data['username']).to eq(params[:username])
      end

      it "does not respond with token in 'Authorization' header" do
        expect(response.headers['Authorization']).to be_blank
      end
    end

    let(:path) { "#{base_url}/login/" }
    let(:user) { create(:user) }

    before do
      post path, params: params.to_json
    end

    context "when valid credentials" do
      let(:params) { { username: user.username, password: user.password } }

      it "responds with HTTP 200 status" do
        expect(response.status).to eq(200)
      end

      it "responds with message about successful login" do
        expect(data['message']).to eq("Login successfully.")
      end

      it "responds with specified username" do
        expect(data['username']).to eq(params[:username])
      end

      it "responds with token in 'Authorization' header" do
        expect(response.headers['Authorization']).to be_present
      end
    end

    context "when invalid credentials" do
      let(:params) { { username: user.username, password: "Incorrect" } }

      include_examples "invalid credentials"
    end

    context "when no user with specified username" do
      let(:params) { { username: "nonexistent", password: "nonexistent" } }

      include_examples "invalid credentials"
    end
  end
end
