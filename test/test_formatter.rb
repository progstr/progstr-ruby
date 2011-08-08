require 'helper'

class TestFormatter < Test::Unit::TestCase
  should "serialize level" do
    device = Progstr::LoggerDevice.new
    formatter = device.formatter

    yesterday = Time.now - 1 * 60 * 60 * 24
    message = formatter.call("WARN", yesterday, "progname", "message body")
    assert_equal "progname", message.source
    assert_equal :warning, message.level
    assert_equal "message body", message.text
    assert_equal yesterday, message.time
  end

  should "infer progname from constructor" do
    device = Progstr::LoggerDevice.new("default-progname")
    formatter = device.formatter

    yesterday = Time.now - 1 * 60 * 60 * 24
    message = formatter.call("WARN", yesterday, nil, "message body")
    assert_equal "default-progname", message.source
  end
end
