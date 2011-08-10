module Progstr
  class RailsLogger < Progstr::Logger
    def initialize
      super("Rails")
    end

    def self.start(rails_config)
      rails_config.after_initialize do
        Rails.logger = rails_config.logger = Progstr::RailsLogger.new
      end
    end
  end
end

