require 'helper'

class TestProgstrRuby < Test::Unit::TestCase
  should "serialize text and source" do
    message = Progstr::LogMessage.new :text => "test message", 
      :source => "progstr.something",
      :host => "dev-machine"
    assert_equal "test message", message.to_hash[:text]
    assert_equal "progstr.something", message.to_hash[:source]
    assert_equal "dev-machine", message.to_hash[:host]
  end

  should "serialize level" do
    message = Progstr::LogMessage.new :level => :info
    assert_equal 0, message.to_hash[:level]
  end
  
  should "serialize time in millis since epoch start (UTC)" do
    now = Time.now
    nowMillis = (now.to_f * 1000).to_i
    message = Progstr::LogMessage.new :time => now
    assert_equal nowMillis, message.to_hash[:time]
  end

  should "get current time if not given" do
    message = Progstr::LogMessage.new({})
    assert message.to_hash[:time] > 0, "time not valid"
  end

  should "get machine name" do
    message = Progstr::LogMessage.new({})
    assert message.to_hash[:host].to_s.size > 0, "host name not inferred"
  end

  should "serialize to json" do
    newYear = Time.utc(2011, 1, 1)
    message = Progstr::LogMessage.new :text => "test message", 
      :source => "progstr.something",
      :host => "dev-machine",
      :level => :error,
      :time => newYear
    expectedJson = "{\"host\":\"dev-machine\",\"time\":1293840000000,\"source\":\"progstr.something\",\"level\":2,\"text\":\"test message\"}"
    assert_equal expectedJson, MultiJson.encode(message)
  end
end
