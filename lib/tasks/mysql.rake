require 'yaml'
namespace :mysql do
  desc "opens the cli"
  task :cli do
    config = RailsMysql::DatabaseConfig.from_yaml(Rails.env)
    RailsMysql::CliCommand.new(config).execute
  end

  desc "dumps to a timestamped file"
  task :dump do
    config = RailsMysql::DatabaseConfig.from_yaml(Rails.env)
    RailsMysql::DumpCommand.new(config).execute
  end

end
