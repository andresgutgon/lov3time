source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

gem "rails", "~> 7.0.4", ">= 7.0.4.2"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"


## MAYBE INSTALL
# gem "redis", "~> 4.0"
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'guard'
  gem 'guard-rspec'
end

group :test do
  gem 'database_cleaner', '~> 1.7.0'
  gem 'rspec-json_expectations'
  gem 'rspec-rails', '~> 6.0.0.rc1'
  gem 'timecop', '0.9.5'
end
