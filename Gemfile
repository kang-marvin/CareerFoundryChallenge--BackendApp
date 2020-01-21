source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'

# Use postgres as the Active record database
gem 'pg'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'jwt'
gem 'simple_command'
gem 'rails-erd'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', require: 'rack/cors'
gem 'httparty'
gem 'oj'
gem 'rack-timeout'

# Caching
gem 'redis'
gem 'redis-rails'
gem 'redis-namespace'

# ActiveJob queue adapter
gem 'sidekiq'

# Performance Monitoring
gem 'newrelic_rpm'

# Model Serializers
gem 'active_model_serializers'

# Pretty URL's
gem 'friendly_id', '~> 5.2.0'

# Column Whitespace cleaner
gem 'auto_strip_attributes', '~> 2.1'

# API pagination
gem 'will_paginate'
gem 'pager_api'
gem 'pagy'

# For defining and setting default values
gem 'default_value_for'

# Database query and query speed
gem 'pg_search'

# Pluck to hash data
gem 'pluck_to_hash'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'figaro'
  gem 'foreman'
  gem 'rspec-rails', '~> 3.5'
  gem 'rubocop', '~> 0.49.1',   require: false
  gem 'shoulda-matchers'
  gem 'dotenv-rails', '~> 2.0.1'
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
  gem 'pry'
  gem 'pry-rails'
  # Pry depends on this gem, I have no idea why.
  gem 'rb-readline'
  gem 'guard-rspec', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
