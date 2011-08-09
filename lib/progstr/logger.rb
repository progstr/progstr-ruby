require 'logger'

module Progstr
  RubyLogger = Logger

  class Logger < RubyLogger
    def initialize(source_name = "Unknown")
      device = LoggerDevice.new(source_name)
      super(device)

      @formatter = device.formatter
    end
  end
end
