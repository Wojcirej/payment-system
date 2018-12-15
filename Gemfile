source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cors', '~> 1.0', '>= 1.0.2'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'active_model_serializers', '~> 0.10.7'
gem 'ruby-enum', '~> 0.7.2'
gem 'kaminari', '~> 1.1', '>= 1.1.1'
gem 'pry', '~> 0.11.3'
gem 'pry-rails', '~> 0.3.6'
gem 'faker', '~> 1.8', '>= 1.8.7'

group :development, :test do
  gem 'figaro', '~> 1.1', '>= 1.1.1'
  gem 'awesome_print', '~> 1.8'
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'factory_bot_rails', '~> 4.10'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
  gem 'database_cleaner', '~> 1.7'
  gem 'simplecov', '~> 0.16.1', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

ruby '2.5.1'
