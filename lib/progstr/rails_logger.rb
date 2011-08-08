module Progstr
  class RailsLogger < Logger
    def initialize
      device = LoggerDevice.new("Rails")
      super(device)

      @formatter = device.formatter
    end
  end
end

