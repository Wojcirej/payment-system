source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 5.2.0'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'ruby-enum', '~> 0.7.2'

group :development, :test do
  gem 'pry', '~> 0.11.3'
  gem 'figaro', '~> 1.1', '>= 1.1.1'
  gem 'rspec-rails', '~> 3.7', '>= 3.7.2'
  gem 'factory_bot_rails', '~> 4.10'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
  gem 'faker', '~> 1.8', '>= 1.8.7'
  gem 'database_cleaner', '~> 1.7'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

ruby '2.5.1'
