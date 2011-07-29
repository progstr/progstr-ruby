module Progstr
  module HttpClient
    HEADERS = {
      'Content-type' => 'application/json',
      'Accept'       => 'application/json'
    }

    class << self
      def post(path, data = '')
        handle_response(http.post(url_path(path), data, headers))
      end

      protected

      def protocol
        "http"
      end

      def url
        URI.parse("#{protocol}://#{Progstr.host}:#{Progstr.port}/")
      end

      def handle_response(response)
        # do nothing even on errors
      end

      def headers
        raise NoApiKeyError if Progstr.api_key.nil?

        @headers ||= HEADERS.merge({ "X-Progstr-Token" => Progstr.api_key.to_s })
      end

      def url_path(path)
        Progstr.path_prefix + path
      end

      def http
        if Thread.current[:http].nil?
          Thread.current[:http] = build_http
        end
        Thread.current[:http]
      end

      def build_http
        http = Net::HTTP::Proxy(Progstr.proxy_host,
                                Progstr.proxy_port,
                                Progstr.proxy_user,
                                Progstr.proxy_pass).new(url.host, url.port)

        http.read_timeout = Progstr.http_read_timeout
        http.open_timeout = Progstr.http_open_timeout
        http.use_ssl = false
        http
      end

      def error_message(response_body)
        Progstr::Json.decode(response_body)["Message"]
      end
    end
  end
end


