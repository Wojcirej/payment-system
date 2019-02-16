require 'rails_helper'

RSpec.describe Paginator do
  subject { described_class }

  describe "constants" do
    it 'should have defined PER_PAGE contstant' do
      expect(subject.const_defined?('PER_PAGE')).to be true
    end

    it 'should have defined PAGE contstant' do
      expect(subject.const_defined?('PAGE')).to be true
    end
  end

  describe "#initialize" do
    let(:collection) { create_list(:employee, 2) }

    context "when pagination params specified" do
      let(:page) { 2 }
      let(:per_page) { 1 }

      it "initializes 'page' with value passed" do
        expect(subject.new(collection, page, per_page).page).to eq(page)
      end

      it "initializes 'per_page' with value passed" do
        expect(subject.new(collection, page, per_page).per_page).to eq(per_page)
      end
    end

    context "when pagination params not specified" do
      let(:page) { nil }
      let(:per_page) { nil }

      it "initializes 'page' with default value" do
        expect(subject.new(collection, page, per_page).page).to eq(1)
      end

      it "initializes 'per_page' with default value" do
        expect(subject.new(collection, page, per_page).per_page).to eq(25)
      end
    end
  end

  describe "#call" do
    let(:page) { 2 }
    let(:per_page) { 1 }

    context "when it is ActiveRecord collection" do
      let(:collection) { Employee.all }

      before do
        create_list(:employee, 3)
      end

      include_examples "paginator service"
    end

    context "when it is Array collection" do
      let(:collection) { create_list(:employee, 3) }

      include_examples "paginator service"
    end

    context "when it is not paginable collection" do
      let(:collection) { {} }

      it "raises 'DataNotPaginable' exception" do
        expect { subject.call(collection, page, per_page) }.to raise_error(Paginator::DataNotPaginable)
      end
    end
  end
end
