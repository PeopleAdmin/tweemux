require_relative '../../action_test_helper'
class Tweemux::Action::LogTest  < MiniTest::Unit::TestCase
  include TweemuxActionHelper
  def argv; %w'log' end
  def expected_commands
    [
      %w(sudo tail -f  /var/log/messages /var/log/secure.log)
    ]
  end
end
