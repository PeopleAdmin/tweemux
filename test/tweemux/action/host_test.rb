require_relative '../../action_test_helper'
class Tweemux::Action::HostTest  < MiniTest::Unit::TestCase
  include TweemuxActionHelper
  def argv; %w'host' end
  def expected_commands
    [
      %w(tmux -S /tmp/tweemux.sock start-server),
      %w(tmux -S /tmp/tweemux.sock new) + ['tweemux share'],
    ]
  end
end
