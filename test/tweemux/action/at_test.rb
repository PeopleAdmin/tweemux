require_relative '../../action_test_helper'
class Tweemux::Action::AtTest  < MiniTest::Unit::TestCase
  include TweemuxActionHelper
  def argv; %w'at sharpsaw.org 2233' end
  def expected_commands
    [ %w(ssh sharpsaw.org -p2233 -t tmux -S /tmp/tweemux.sock attach) ]
  end
end

class Tweemux::Action::AtImplicitPortTest  < MiniTest::Unit::TestCase
  include TweemuxActionHelper
  def argv; %w'at sharpsaw.org' end
  def expected_commands
    [ %w(ssh sharpsaw.org -p22 -t tmux -S /tmp/tweemux.sock attach) ]
  end
end
