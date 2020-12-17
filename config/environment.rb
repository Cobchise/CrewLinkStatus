# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

UpdateAllServerMonitorsJob.set(wait: 5.minutes).perform_later if defined? Rails::Server
