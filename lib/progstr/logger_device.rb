module Progstr
  class LoggerDevice
    LEVELS_MAP = {
      "INFO" => :info,
      "WARN" => :warning,
      "ERROR" => :error,
      "FATAL" => :fatal
    }
    def initialize(source = nil)
      @source = source || "Unknown"
    end

    def write(message)
      if !message.nil?
        Progstr::Client::send(message)
      end
    end

    def close
    end

    def formatter
      proc do |severity, datetime, progname, msg|
        level = resolve_level(severity)
        Progstr::LogMessage.new :text => msg,
          :level => resolve_level(severity),
          :time => datetime,
          :source => resolve_source(progname)
      end
    end

    def resolve_level(severity)
      LEVELS_MAP[severity] || :info
    end

    def resolve_source(progname)
      progname || @source
    end
  end
end
