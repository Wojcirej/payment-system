ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
Dir[Rails.root.join("spec/remote_helpers/**/*.rb")].each { |file| require file }
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require "capybara/cuprite"
require 'shoulda/matchers'
Rails.logger.level = 4

Capybara.always_include_port = true
Capybara.run_server = false
Capybara.default_max_wait_time = 10
Capybara.javascript_driver = :cuprite
Capybara.app_host = "#{ENV.fetch('REMOTE_PROTOCOL', 'https')}://#{ENV.fetch('REMOTE_DOMAIN')}"
Capybara.default_host = Capybara.app_host

require 'rack/utils'
Capybara.app = Rack::ShowExceptions.new(PaymentSystemBackend::Application)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.default_formatter = "doc"
  config.profile_examples = 10
  config.order = :random
  config.expect_with :rspec do |c|
    c.syntax = [:expect]
  end
  config.include GeneralRemoteHelpers
end

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(app, {
    window_size: [1680, 1050],
    url_whitelist: [Capybara.app_host, ENV.fetch('REMOTE_BACKEND_URL')]
    })
end
