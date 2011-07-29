module Progstr
  module Client
    extend self

    def send(message)
      pool.schedule do
        begin
          execute(message)
        rescue => error
          p "Progstr::Client.send: #{error.message}"
          p error.backtrace.join("\r\n")
        end
      end
    end

    def pool
      if (@pool.nil?)
        @pool = ThreadPool.new(2)
        at_exit { @pool.shutdown }
      end
      @pool
    end

    def execute(message)
      json = MultiJson.encode(message)
      Progstr::HttpClient::post("v1/log", json)
    end
  end
end
