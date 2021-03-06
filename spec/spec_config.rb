require 'simplecov'
SimpleCov.start do
  add_group("Domain", "app/domain/")
  add_group("Persistence", "app/models/")
  add_group("API", "app/controllers/")
  add_group("Serialization", "app/serializers/")
  add_group("Libs", "lib/")
  add_group("Deployment", "lib/deploy/")
end

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
Dir[Rails.root.join("spec/helpers/**/*.rb")].each { |file| require file }
Dir[Rails.root.join("spec/shared_examples/**/*.rb")].each { |file| require file }
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'database_cleaner'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.default_formatter = "doc"
  config.profile_examples = 10
  config.order = :random

  config.include FactoryBot::Syntax::Methods
  config.include RequestSpecsHelper, type: :request

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
