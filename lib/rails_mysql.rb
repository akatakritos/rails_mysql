require 'yaml'
require "rails_mysql/version"
require "rails_mysql/database_config"
require 'rails_mysql/cli_command'
require 'rails_mysql/dump_command'

require 'rails_mysql/railtie' if defined?(Rails)

module RailsMysql
  # Your code goes here...
  class ConfigurationError < StandardError; end
end
