module RailsMysql
  class CliCommand
    def initialize(config)
      @config = config
    end

    def execute
      Kernel.exec(%Q{mysql -h"#{config.host}" -u"#{config.username}" -p"#{config.password}" -P"#{config.port}" -D"#{config.database}"})
    end

    private
      def config
        @config
      end

  end
end
