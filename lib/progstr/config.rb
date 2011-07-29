module Progstr
  class << self
    attr_accessor :host, :path_prefix, :port, :secure, :api_key, :http_open_timeout, :http_read_timeout, :proxy_host, :proxy_port, :proxy_user, :proxy_pass 

    def host
      @host ||= "app.progstr.com"
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
  end
end
