module RailsMysql
  class DumpCommand

    def initialize(config)
      @config = config
    end

    def command
      cmd_parts = []
      cmd_parts << "-h \"#{config.host}\""     if config.host
      cmd_parts << "-P \"#{config.port}\""     if config.port
      cmd_parts << "-u \"#{config.username}\"" if config.username
      cmd_parts << "-p\"#{config.password}\""  if config.password

      "mysqldump #{cmd_parts.join(' ')} \"#{config.database}\" | gzip > #{filename}"
    end

    def filename
      "db/#{config.database}-#{Time.now.utc.iso8601}.sql.gz"
    end

    private
      def config
        @config
      end
  end
end
