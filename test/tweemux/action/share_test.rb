require_relative '../../action_test_helper'
class Tweemux::Action::ShareTest < MiniTest::Unit::TestCase
  include TweemuxActionHelper
  def argv; %w'share' end
  def expected_commands
    [
      %w(chmod a+rw /tmp/tweemux.sock),
      [ENV['SHELL']],
    ]
  end
end
