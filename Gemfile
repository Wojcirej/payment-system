source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 5.2.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rack-cors', '~> 1.0', '>= 1.0.2'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'active_model_serializers', '~> 0.10.8'
gem 'ruby-enum', '~> 0.7.2'
gem 'kaminari', '~> 1.1', '>= 1.1.1'
gem 'pry', '~> 0.12.2'
gem 'pry-rails', '~> 0.3.9'
gem 'faker', '~> 1.9', '>= 1.9.1'

group :development, :test do
  gem 'figaro', '~> 1.1', '>= 1.1.1'
  gem 'awesome_print', '~> 1.8'
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
  gem 'factory_bot', '~> 4.11', '>= 4.11.1'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.3'
  gem 'database_cleaner', '~> 1.7'
  gem 'simplecov', '~> 0.16.1', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

ruby '2.5.1'
