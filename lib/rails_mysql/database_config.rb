module RailsMysql
  class ConfigurationError < StandardError; end
  class DatabaseConfig

    def self.from_yaml(env, file='config/database.yml')
      self.new(YAML.load_file(file).fetch(env))
    end

    attr_reader :host, :username, :password, :port, :database

    def initialize(options)
      raise ConfigurationError unless options["adapter"] =~ /mysql/

      @host     = options.fetch('host', 'localhost')
      @username = options.fetch('username', 'root')
      @password = options.fetch('password', 'root')
      @port     = options.fetch('port', '3306')
      @database = options.fetch('database', 'db')
    end

  end
end
