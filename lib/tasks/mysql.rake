require 'yaml'
namespace :mysql do
  desc "opens the cli"
  task :cli do
    env = Rails.env
    config = YAML.load_file("config/database.yml").fetch(env)


    host     = config.fetch('host')
    username = config.fetch('username')
    password = config.fetch('password')
    port     = config.fetch('port')
    database = config.fetch('database')

    Kernel.exec("mysql -h#{host} -u#{username} -p#{password} -P#{port} -D#{database}")
  end
end
