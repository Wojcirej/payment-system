require 'rails_helper'

RSpec.describe Api::EmployeesController, type: :request do
  let(:base_url) { "/api/employees" }

  describe "GET /api/employees" do
    let(:path) { base_url }

    context "when employees exist" do
      let!(:employees) { create_list(:employee, 2, :employment_contract) }

      before do
        get path
      end

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

      it "does not respond with errors" do
        expect(errors).to be_blank
      end
    end

    context "when employees do not exist" do

      before do
        get path
      end

      it "responds with HTTP 200 status" do
        expect(response.status).to eq(200)
      end

      it "responds with empty list" do
        expect(data.size).to eq(0)
      end

      it "does not respond with errors" do
        expect(errors).to be_blank
      end
    end
  end
end
