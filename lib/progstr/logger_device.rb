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
        unless level.nil?
          Progstr::LogMessage.new :text => msg,
            :level => resolve_level(severity),
            :time => datetime,
            :source => resolve_source(progname)
        else
          nil
        end
      end
    end

    def resolve_level(severity)
      level = LEVELS_MAP[severity]
      if level.nil? && Progstr.log_debug_events
        level = :info
      end
      level
    end

    def resolve_source(progname)
      progname || @source
    end
  end
end
