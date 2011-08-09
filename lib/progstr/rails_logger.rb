module Progstr
  class RailsLogger < Progstr::Logger
    def initialize
      super("Rails")
    end
  end
end

