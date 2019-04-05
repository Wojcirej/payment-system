require 'spec_config'
require './lib/deploy/deploy'

RSpec.describe Deploy do
  subject { described_class.new(options) }
  let(:options) do
    {
      stage: stage,
      migrations: migrations,
      bump: bump_type,
    }
  end
  let(:bump_type) { false }
  let(:migrations) { false }

  describe "#run" do

    before do
      allow_any_instance_of(described_class).to receive(:push_command).and_return("")
      allow_any_instance_of(described_class).to receive(:enable_maintenance_mode_command).and_return("")
      allow_any_instance_of(described_class).to receive(:run_migrations_command).and_return("")
      allow_any_instance_of(described_class).to receive(:disable_maintenance_mode_command).and_return("")
    end

    context "when invalid stage" do
      let(:stage) { "invalid" }

      it "does not proceed with deploy" do
        expect_any_instance_of(described_class).not_to receive(:push)
        described_class.run(options)
      end
    end

    context "when valid stage" do
      let(:stage) { "staging" }

      it "proceeds with deploy by making push to specified stage" do
        expect_any_instance_of(described_class).to receive(:push)
        described_class.run(options)
      end

      it "calls 'system' method to make push to remote" do
        expect_any_instance_of(Kernel).to receive(:system).once
        described_class.run(options)
      end
    end

    context "when migrations requested" do
      let(:stage) { "staging" }
      let(:migrations) { true }

      it "enables maintenance mode" do
        expect_any_instance_of(described_class).to receive(:enable_maintenance_mode)
        described_class.run(options)
      end

      it "makes push to specified stage" do
        expect_any_instance_of(described_class).to receive(:push)
        described_class.run(options)
      end

      it "runs migrations after push" do
        expect_any_instance_of(described_class).to receive(:run_migrations)
        described_class.run(options)
      end

      it "disables maintenance mode after push" do
        expect_any_instance_of(described_class).to receive(:disable_maintenance_mode)
        described_class.run(options)
      end

      it "calls 'system method' for all related operations" do
        expect_any_instance_of(Kernel).to receive(:system).exactly(4).times
        described_class.run(options)
      end
    end

    context "when version bump requested" do
      let(:stage) { "staging" }
      let(:migrations) { false }
      let(:bump_type) { :major }

      before do
        allow(Versioner).to receive(:call).and_return(nil)
      end

      it "calls Versioner command class" do
        expect(Versioner).to receive(:call).with(options)
        described_class.run(options)
      end
    end
  end

  describe "#push_command" do

    context "when 'stage' set to 'staging'" do
      let(:stage) { "staging" }

      it "returns git push command with remote='staging' and source branch 'develop'" do
        expect(subject.send(:push_command)).to eq("git push staging develop:master")
      end
    end

    context "when 'stage' set to 'production'" do
      let(:stage) { "production" }

      it "returns git push command with remote='production' and source branch 'master'" do
        expect(subject.send(:push_command)).to eq("git push production master:master")
      end
    end
  end

  describe "#enable_maintenance_mode_command" do

    context "when 'stage' set to 'staging'" do
      let(:stage) { "staging" }

      it "returns heroku command enabling maintenance mode on staging" do
        expect(subject.send(:enable_maintenance_mode_command)).to eq("heroku maintenance:on --remote staging")
      end
    end

    context "when 'stage' set to 'production'" do
      let(:stage) { "production" }

      it "returns heroku command enabling maintenance mode on production" do
        expect(subject.send(:enable_maintenance_mode_command)).to eq("heroku maintenance:on --remote production")
      end
    end
  end

  describe "#run_migrations_command" do

    context "when 'stage' set to 'staging'" do
      let(:stage) { "staging" }

      it "returns heroku command running migrations on staging" do
        expect(subject.send(:run_migrations_command)).to eq("heroku run rake db:migrate --remote staging")
      end
    end

    context "when 'stage' set to 'production'" do
      let(:stage) { "production" }

      it "returns heroku command running migrations on production" do
        expect(subject.send(:run_migrations_command)).to eq("heroku run rake db:migrate --remote production")
      end
    end
  end

  describe "#disable_maintenance_mode_command" do

    context "when 'stage' set to 'staging'" do
      let(:stage) { "staging" }

      it "returns heroku command disabling maintenance mode on staging" do
        expect(subject.send(:disable_maintenance_mode_command)).to eq("heroku maintenance:off --remote staging")
      end
    end

    context "when 'stage' set to 'production'" do
      let(:stage) { "production" }

      it "returns heroku command disabling maintenance mode on production" do
        expect(subject.send(:disable_maintenance_mode_command)).to eq("heroku maintenance:off --remote production")
      end
    end
  end
end
