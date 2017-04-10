# Use bundler to load gems
require 'bundler'
require './models/rs/rsServer'
require_relative './models/rs/client'
require_relative './models/rs/clientHandler'

# Load gems from Gemfile
Bundler.require

# Load settings for development/production/test environments
require_relative 'config/environment'

# Start the application
server = RSServer.new
run App.new(server)