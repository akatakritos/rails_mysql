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
    Kernel.exec("mysqldump -h \"#{config.host}\" -u \"#{config.username}\" -p \"#{config.password}\" -P \"#{config.port}\"")
  end

end
