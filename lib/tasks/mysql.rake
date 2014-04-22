require 'yaml'
namespace :mysql do
  desc "opens the cli"
  task :cli do
    config = RailsMysql::DatabaseConfig.from_yaml(Rails.env)
   RakeFileUtils.sh RailsMysql::CliCommand.new(config).command
  end

  desc "dumps to a timestamped file"
  task :dump do
    config = RailsMysql::DatabaseConfig.from_yaml(Rails.env)
    RakeFileUtils.sh RailsMysql::DumpCommand.new(config).command
  end

end
