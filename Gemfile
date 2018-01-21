source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# Add authentication methods
gem 'sorcery'

# Manage pagination for us
gem 'kaminari'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # Call 'ap' anywhere in the code to pretty print your Ruby objects with style
  gem 'awesome_print', require: 'ap'
  gem 'rspec-rails', '~> 3.6'
  gem 'factory_bot_rails', '~> 4.8'
  gem 'timecop', '~> 0.8'
  gem 'json_matchers'
  gem 'faker'
  gem 'action-cable-testing'

  # Linters
  gem 'pronto', require: false
  gem 'pronto-eslint', require: false
  gem 'pronto-rubocop', require: false
  gem 'pronto-scss', require: false
  gem 'rubocop', require: false
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
