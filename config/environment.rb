# Load the rails application
require File.expand_path('../application', __FILE__)

env_vars = File.join(Rails.root, 'config', 'env_vars.rb')
load(env_vars) if File.exists?(env_vars)

# Initialize the rails application
Lildebbie::Application.initialize!
