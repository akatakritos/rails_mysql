require 'rails'
module RailsMysql
  class Railtie < Rails::Railtie
    railtie_name :rails_mysql

    rake_tasks do
      load "tasks/mysql.rake"
    end
  end
end
