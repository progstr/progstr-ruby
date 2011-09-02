module Progstr
  class RailsLogger < Progstr::Logger
    def initialize
      super("Rails")
    end

    def self.start(rails_config)
      rails_config.after_initialize do
        Rails.logger = rails_config.logger = Progstr::RailsLogger.new

        #specific loggers for ActionController and ActiveRecord
        if defined? ActionController
          ActionController::Base.logger = Progstr::Logger.new("ActionController")
        end
        if defined? ActiveRecord
          ActiveRecord::Base.logger = Progstr::Logger.new("ActiveRecord")
        end
      end
    end
  end
end

