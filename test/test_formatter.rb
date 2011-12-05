require 'helper'

class TestFormatter < Test::Unit::TestCase
  yesterday = Time.now - 1 * 60 * 60 * 24

  should "serialize level" do
    device = Progstr::LoggerDevice.new
    formatter = device.formatter

    message = formatter.call("WARN", yesterday, "progname", "message body")
    assert_equal "progname", message.source
    assert_equal :warning, message.level
    assert_equal "message body", message.text
    assert_equal yesterday, message.time
  end

  should "ignore unknown(debug) severity entries by default" do
    device = Progstr::LoggerDevice.new
    formatter = device.formatter

    message = formatter.call("DEBUG", yesterday, "progname", "message body")
    assert_nil message
  end

  should "log unknown(debug) entries if explicitly allowed" do
    begin
      Progstr.log_debug_events = true
      device = Progstr::LoggerDevice.new
      formatter = device.formatter

      message = formatter.call("DEBUG", yesterday, "progname", "message body")
      assert_equal "progname", message.source
      assert_equal :info, message.level
      assert_equal "message body", message.text
      assert_equal yesterday, message.time
    ensure
      Progstr.log_debug_events = false
    end
  end

  should "infer progname from constructor" do
    device = Progstr::LoggerDevice.new("default-progname")
    formatter = device.formatter

    message = formatter.call("WARN", yesterday, nil, "message body")
    assert_equal "default-progname", message.source
  end
end
