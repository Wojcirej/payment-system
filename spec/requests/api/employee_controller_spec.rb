require 'rails_helper'

RSpec.describe Api::EmployeesController, type: :request do
  let(:base_url) { "/api/employees" }
  let(:number_of_json_keys) { 7 }

  describe "GET /api/employees" do
    let(:path) { base_url }

    context "when employees exist" do
      let!(:employees) { create_list(:employee, 2, :employment_contract) }

      before do
        get path
      end

      it_behaves_like "paginable endpoint"

      it "responds with HTTP 200 status" do
        expect(response.status).to eq(200)
      end

      it "responds with list of all employees" do
        aggregate_failures "list of all employees" do
          expect(data.size).to eq(employees.size)
          expected_employees = employees.map { |employee| employee.id }
          received_employees = data.map { |employee| employee["id"] }
          expect(expected_employees).to match_array(received_employees)
        end
      end
    end

    context "when employees do not exist" do

      before do
        get path
      end

      it_behaves_like "paginable endpoint"

      it "responds with HTTP 200 status" do
        expect(response.status).to eq(200)
      end

      it "responds with empty list" do
        expect(data.size).to eq(0)
      end
    end
  end

  describe "GET /api/employees/:id" do

    context "when requested employee exist" do
      let(:path) { "#{base_url}/#{employee.id}" }
      let(:employee) { create(:employee) }

      before do
        get path
      end

      it "responds with HTTP 200 status" do
        expect(response.status).to eq(200)
      end

      it "responds with requested employee" do
        expect(data['id']).to eql(employee.id)
      end

      it "responds with serialized employee" do
        expect(data.size).to eql(number_of_json_keys)
      end

      it "does not respond with errors" do
        expect(errors).to be_blank
      end
    end

    context "when employee with requested ID does not exist" do
      let(:path) { "#{base_url}/-1" }

      before do
        get path
      end

      it "responds with HTTP 404 status" do
        expect(response.status).to eq(404)
      end

      it "does not respond with any data" do
        expect(data).not_to be_present
      end

      it "responds with message" do
        expect(message).to be_present
      end

      it "responds with message about not existing record" do
        expect(message).to eql("Couldn't find Employee with 'id'=-1")
      end
    end
  end

  describe "POST /api/employees" do
    let(:path) { base_url }

    before do
      post path, params: params.to_json
    end

    context "when valid request params" do
      let(:params) { build(:employee, :employment_contract).
        serializable_hash.except("id", "created_at", "updated_at") }

      it "responds with HTTP 201 status" do
        expect(response.status).to eq(201)
      end

      it "responds with created employee" do
        expect(data['firstName']).to eql(params['first_name'])
      end

      it "responds with serialized employee" do
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
          expect(errors['firstName']).to include("Please specify employee's first name.")
          expect(errors['lastName']).to include("Please specify employee's last name.")
          expect(errors['contractType']).to include("Not supported type of contract.")
        end
      end

      it "responds with error messages" do
        expect(error_messages.size).to eq(3)
      end
    end
  end
end
