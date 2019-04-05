require 'spec_config'
require './lib/deploy/versioner'

RSpec.describe Versioner do
  subject { described_class.new(options) }
  let(:options) do
    {
      stage: :staging,
      bump: bump_type,
    }
  end
  let(:bump_type) { false }

  describe ".call" do
    let(:bump_type) { :patch }

    before do
      allow_any_instance_of(described_class).to receive(:current_version).and_return("0.3.15")
      allow_any_instance_of(described_class).to receive(:change_version_file).and_return(true)
      allow_any_instance_of(described_class).to receive(:set_version_tag_command).and_return("")
      allow_any_instance_of(described_class).to receive(:push_tag_command).and_return("")
      allow_any_instance_of(described_class).to receive(:commit_new_version_number_command).and_return("")
      allow_any_instance_of(described_class).to receive(:push_new_version_number_command).and_return("")
    end

    it "bumps version number accordingly to the 'bump_type'" do
      expect_any_instance_of(described_class).to receive(:bump_number)
      described_class.call(options)
    end

    it "writes new version number into version.rb file" do
      expect_any_instance_of(described_class).to receive(:change_version_file)
      described_class.call(options)
    end

    it "makes new commit with new version number" do
      expect_any_instance_of(described_class).to receive(:commit_new_version_number)
      described_class.call(options)
    end

    it "pushes commit with new version number to the remote repository" do
      expect_any_instance_of(described_class).to receive(:push_new_version_number)
      described_class.call(options)
    end

    it "creates tag with new version number" do
      expect_any_instance_of(described_class).to receive(:set_version_tag)
      described_class.call(options)
    end

    it "pushes new tag with new version number to the remote repository" do
      expect_any_instance_of(described_class).to receive(:push_tag)
      described_class.call(options)
    end
  end

  describe "#bump_number" do

    before do
      allow_any_instance_of(described_class).to receive(:current_version).and_return("0.3.15")
    end

    context "when 'bump_type' set to patch" do
      let(:bump_type) { :patch }

      it "bumps last number of the version" do
        versioner = subject
        versioner.send(:bump_number)
        expect(versioner.send(:new_version)).to eq("0.3.16")
      end
    end

    context "when 'bump_type' set to minor" do
      let(:bump_type) { :minor }

      it "bumps middle number of the version and sets to 0 last number of the version" do
        versioner = subject
        versioner.send(:bump_number)
        expect(versioner.send(:new_version)).to eq("0.4.0")
      end
    end

    context "when 'bump_type' set to major" do
      let(:bump_type) { :major }

      it "bumps first number of the version and sets to 0 last and middle numbers of the version" do
        versioner = subject
        versioner.send(:bump_number)
        expect(versioner.send(:new_version)).to eq("1.0.0")
      end
    end
  end

  describe "#version_file_template" do

    before do
      allow_any_instance_of(described_class).to receive(:new_version).and_return("0.3.15")
    end

    it "returns version file template with new version number" do
      versioner = subject
      template = versioner.send(:version_file_template)
      expect(template).to eq("module PaymentSystemBackend\n  VERSION = \"0.3.15\"\nend\n")
    end
  end

  describe "#set_version_tag" do

    context "when 'new_version' not set" do

      it "does not call 'system' function" do
        versioner = subject
        expect_any_instance_of(Kernel).not_to receive(:system)
        versioner.send(:set_version_tag)
      end
    end

    context "when 'new_version' set" do

      before do
        allow_any_instance_of(described_class).to receive(:new_version).and_return("0.3.15")
        allow_any_instance_of(described_class).to receive(:set_version_tag_command).and_return("")
      end

      it "does call 'system' function" do
        versioner = subject
        expect_any_instance_of(Kernel).to receive(:system)
        versioner.send(:set_version_tag)
      end
    end
  end

  describe "#push_tag" do

    context "when 'new_version' not set" do

      it "does not call 'system' function" do
        versioner = subject
        expect_any_instance_of(Kernel).not_to receive(:system)
        versioner.send(:push_tag)
      end
    end

    context "when 'new_version' set" do

      before do
        allow_any_instance_of(described_class).to receive(:new_version).and_return("0.3.15")
        allow_any_instance_of(described_class).to receive(:push_tag_command).and_return("")
      end

      it "does call 'system' function" do
        versioner = subject
        expect_any_instance_of(Kernel).to receive(:system)
        versioner.send(:push_tag)
      end
    end
  end

  describe "#set_version_tag_command" do

    before do
      allow_any_instance_of(described_class).to receive(:new_version).and_return("0.3.15")
    end

    it "returns git command string creating tag with new_version number" do
      versioner = subject
      expect(versioner.send(:set_version_tag_command)).to eq("git tag -a v0.3.15 -m\"v0.3.15\"")
    end
  end

  describe "#push_tag_command" do

    before do
      allow_any_instance_of(described_class).to receive(:new_version).and_return("0.3.15")
    end

    it "returns git command string creating tag with new_version number" do
      versioner = subject
      expect(versioner.send(:push_tag_command)).to eq("git push origin v0.3.15")
    end
  end

  describe "#commit_new_version_number" do

    context "when 'new_version' not set" do

      it "does not call 'system' function" do
        versioner = subject
        expect_any_instance_of(Kernel).not_to receive(:system)
        versioner.send(:commit_new_version_number)
      end
    end

    context "when 'new_version' set" do

      before do
        allow_any_instance_of(described_class).to receive(:new_version).and_return("0.3.15")
        allow_any_instance_of(described_class).to receive(:commit_new_version_number_command).and_return("")
      end

      it "does call 'system' function" do
        versioner = subject
        expect_any_instance_of(Kernel).to receive(:system)
        versioner.send(:commit_new_version_number)
      end
    end
  end

  describe "#commit_new_version_number_command" do

    before do
      allow_any_instance_of(described_class).to receive(:new_version).and_return("0.3.15")
    end

    it "returns git command string creating commit with new_version number" do
      versioner = subject
      expect(versioner.send(:commit_new_version_number_command)).to eq("git commit -am \"v0.3.15\"")
    end
  end

  describe "#push_new_version_number" do

    context "when 'new_version' not set" do

      it "does not call 'system' function" do
        versioner = subject
        expect_any_instance_of(Kernel).not_to receive(:system)
        versioner.send(:push_new_version_number)
      end
    end

    context "when 'new_version' set" do

      before do
        allow_any_instance_of(described_class).to receive(:new_version).and_return("0.3.15")
        allow_any_instance_of(described_class).to receive(:push_new_version_number_command).and_return("")
      end

      it "does call 'system' function" do
        versioner = subject
        expect_any_instance_of(Kernel).to receive(:system)
        versioner.send(:push_new_version_number)
      end
    end
  end

  describe "#push_new_version_number_command" do

    it "returns git command string creating commit with new_version number" do
      versioner = subject
      expect(versioner.send(:push_new_version_number_command)).to eq("git push origin develop")
    end
  end
end
