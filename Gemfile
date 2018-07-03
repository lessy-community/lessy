source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1'
# Use sqlite3 as the database for Active Record
gem 'pg', '~> 1.0'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# Add authentication methods
gem 'sorcery', '~> 0.12'

# Manage pagination for us
gem 'kaminari', '~> 1.1'

# Generate administration
gem 'administrate', '~> 0.8'

# Support for feature flags
gem 'flipper', '~> 0.12'
gem 'flipper-active_record', '~> 0.12'

# Provide a lock system for DB
gem 'with_advisory_lock', '~> 3.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 10.0', platform: :mri
  # Call 'ap' anywhere in the code to pretty print your Ruby objects with style
  gem 'awesome_print', '~> 1.8', require: 'ap'
  gem 'rspec-rails', '~> 3.6'
  gem 'factory_bot_rails', '~> 4.8'
  gem 'timecop', '~> 0.8'
  gem 'json_matchers', '~> 0.7'
  gem 'faker', '~> 1.8'
  gem 'action-cable-testing', '~> 0.2'
  gem 'rubocop', '~> 0.52', require: false
  gem 'shoulda-matchers', '~> 3.1'
end

group :development do
  gem 'listen', '~> 3.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 2.0'
  gem 'spring-watcher-listen', '~> 2.0'

  gem 'letter_opener', '~> 1.4'

  gem 'foreman', '~> 0.84'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
