module Progstr
  class << self
    attr_accessor :host, :path_prefix, :port, :secure, :api_key, :http_open_timeout, :http_read_timeout, :proxy_host, :proxy_port, :proxy_user, :proxy_pass, :log_debug_events
    attr_writer :api_key, :log_debug_events

    def api_key
      @api_key || ENV['PROGSTR_API_KEY']
    end

    def log_debug_events
      @log_debug_events || !ENV['PROGSTR_LOG_DEBUG'].nil?
    end

    def host
      @host ||= "api.progstr.com"
    end
    def port
      @port || 80
    end
    def path_prefix
      @path_prefix ||= '/'
    end
    def http_open_timeout
      @http_open_timeout ||= 5
    end

    def http_read_timeout
      @http_read_timeout ||= 15
    end

    def log_debug_events
      @log_debug_events ||= false
    end
  end
end
