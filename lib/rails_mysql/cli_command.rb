module RailsMysql
  class CliCommand
    def initialize(config)
      @config = config
    end

    def command
      cmd_parts = []
      cmd_parts << "-h\"#{config.host}\""     if config.host
      cmd_parts << "-u\"#{config.username}\"" if config.username
      cmd_parts << "-p\"#{config.password}\"" if config.password
      cmd_parts << "-P\"#{config.port}\""     if config.port
      cmd_parts << "-D\"#{config.database}\"" if config.database

      %Q{mysql #{cmd_parts.join(' ')}}.strip
    end

    private
      def config
        @config
      end

  end
end
