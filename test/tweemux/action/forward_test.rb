require_relative '../../action_test_helper'
class Tweemux::Action::ForwardTest  < MiniTest::Unit::TestCase
  include TweemuxActionHelper
  def argv; %w'forward local 22 from sharpsaw.org 3322' end
  def expected_commands
    [ %w(ssh -fNR 3322:localhost:22 sharpsaw.org) ]
  end

  def bad_runs
    [
      %w(forward asdf asdf),
      %w(forward local hi from sharpsaw.org 3322),
      %w(forward local 22 from sharpsaw.org hi),
      %w(forward local 22 zipzip sharpsaw.org 3322),
    ]
  end
end
