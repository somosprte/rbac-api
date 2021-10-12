# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-meta'
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop-performance'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

path 'engines' do
  gem 'auth'
  gem 'experience'
  gem 'gallery'
  gem 'user'
end

# Easy cloning of active_record objects including associations and several operations under associations and attributes.
gem 'amoeba'
# The official AWS SDK for Ruby. http://aws.amazon.com/sdkforruby
gem 'aws-sdk-s3'
# An easy way to keep your users' passwords secure.
gem 'bcrypt'
# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for modern web app frameworks and ORMs
gem 'kaminari'
# A ruby wrapper for ImageMagick or GraphicsMagick command line.
gem 'mini_magick'
# Easy file attachment management for ActiveRecord https://thoughtbot.com/open-source
gem 'paperclip'
# Fast, Nimble PDF Writer for Ruby http://prawnpdf.org
gem 'prawn'
# Provides support for tables in Prawn
gem 'prawn-table'
# RailsAdmin is a Rails engine that provides an easy-to-use interface for managing your data
gem 'rails_admin'
# Seamlessly adds a Swagger to Rails-based API's
gem 'rswag'
# Ruby HTML and CSS sanitizer.
gem 'sanitize'
