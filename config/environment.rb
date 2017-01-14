# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Make JBuilder lower-cased attributes to be JavaScript-style-compliant
Jbuilder.key_format camelize: :lower
