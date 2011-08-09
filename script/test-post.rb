require "progstr"

Progstr.api_key = "DEMO"

logger = Progstr::Logger.new("console-script")
logger.info("Something funny")
logger.info("source-override") { "Something funny with custom source" }

rails_logger = Progstr::RailsLogger.new
rails_logger.info("Something funny in Rails-land.")
