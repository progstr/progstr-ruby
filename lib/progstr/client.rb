module Progstr
  module Client
    extend self

    def send(message)
      raise NoApiKeyError if Progstr.api_key.nil?

      pool.schedule do
        begin
          execute(message)
        rescue Timeout::Error, 
                Errno::EINVAL,
                Errno::ECONNRESET,
                Errno::ECONNREFUSED,
                EOFError,
                SocketError,
                Net::HTTPBadResponse,
                Net::HTTPHeaderSyntaxError,
                Net::ProtocolError => error
          #puts "Progstr::Client.send: #{error.message}"
          #puts error.backtrace.join("\r\n")
        end
      end
    end

    private

    def pool
      if (@pool.nil?)
        @pool = ThreadPool.new(2)
        at_exit { @pool.shutdown }
      end
      @pool
    end

    def execute(message)
      json = MultiJson.encode(message.to_hash)
      Progstr::HttpClient::post("v1/log", json)
    end
  end
end
