module Progstr
  class LogMessage
    LEVELS = { :info => 0, :warning => 1, :error => 2, :fatal => 3 } 
    LEVELS.default = 0

    attr_reader :text, :source, :host, :level, :time

    def initialize(params)
      @text = params[:text]
      @source = params[:source]
      @host = params[:host]
      @level = params[:level]
      @time = params[:time]
    end

    def to_hash
      {:text => @text, :source => @source, :host => get_host(@host), :level => LEVELS[@level], :time => encode_time(@time)}
    end

    def encode_time(time)
      time ||= Time.now
      (time.to_f * 1000).to_i
    end

    def get_host(host)
      host || Socket.gethostname || ENV["HOST"] || "Unknown"
    end
  end
end
