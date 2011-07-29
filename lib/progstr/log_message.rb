module Progstr
  class LogMessage
    LEVELS = { :info => 0, :warning => 1, :error => 2, :fatal => 3 } 
    LEVELS.default = 0

    def initialize(params)
      @text = params[:text]
      @source = params[:source]
      @host = params[:host]
      @level = params[:level]
      @time = params[:time]
    end

    def to_hash
      {:text => @text, :source => @source, :host => @host, :level => LEVELS[@level], :time => encode_time(@time)}
    end

    def to_json
      to_hash.to_json
    end

    def encode_time(time)
      (time.to_f * 1000).to_i
    end
  end
end