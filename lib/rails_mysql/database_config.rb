module RailsMysql
  class ConfigurationError < StandardError; end
  class DatabaseConfig

    def self.from_yaml(env, file='config/database.yml')
      self.new(YAML.load_file(file).fetch(env))
    end

    attr_reader :host, :username, :password, :port, :database

    def initialize(options)
      raise ConfigurationError, "Not a mysql adapter" unless options["adapter"] =~ /mysql/

      @host     = options['host']
      @username = options['username']
      @password = options['password']
      @port     = options['port']
      @database = options['database']
    end

  end
end
