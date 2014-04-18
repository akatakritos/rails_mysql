require 'yaml'
namespace :mysql do
  desc "opens the cli"
  task :cli do
    env = Rails.env
    config = RailsMysql::DatabaseConfig.from_yaml(env)

    Kernel.exec("mysql -h#{config.host} -u#{config.username} -p#{config.password} -P#{config.port} -D#{config.database}")
  end
end
