require_relative '../../action_test_helper'
class Tweemux::Action::OnTest  < MiniTest::Unit::TestCase
  include TweemuxActionHelper
  def argv; %w'at sharpsaw.org 2233' end
  def expected_commands
    [ %w(ssh sharpsaw.org -p2233 -t PATH=/usr/local/bin:/usr/bin tmux -2uS /tmp/tweemux.sock attach) ]
  end
end

class Tweemux::Action::OnImplicitPortTest  < MiniTest::Unit::TestCase
  include TweemuxActionHelper
  def argv; %w'on sharpsaw.org' end
  def expected_commands
    [ %w(ssh sharpsaw.org -t PATH=/usr/local/bin:/usr/bin tmux -2uS /tmp/tweemux.sock attach) ]
  end
end
