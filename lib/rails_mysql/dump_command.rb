module RailsMysql
  class DumpCommand

    def initialize(config)
      @config = config
    end

    def command
      "mysqldump -h \"#{config.host}\" -P \"#{config.port}\" -u \"#{config.username}\" -p \"#{config.password}\" \"#{config.database}\" | gzip > #{filename}"
    end

    def filename
      "db/#{Time.now.utc.iso8601}.sql.gz"
    end

    private
      def config
        @config
      end
  end
end
