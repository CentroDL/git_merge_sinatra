require 'bundler'

Bundler.require

require_relative 'rugged_test'

run Sinatra::Application
