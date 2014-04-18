require 'yaml'
namespace :mysql do
  desc "opens the cli"
  task :cli do
    config = RailsMysql::DatabaseConfig.from_yaml(Rails.env)
    RailsMysql::CliCommand.new(config).execute
  end
end
