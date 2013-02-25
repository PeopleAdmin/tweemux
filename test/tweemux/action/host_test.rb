# XXX copy
require_relative '../../test_helper'
class Tweemux::Action::HostTest < MiniTest::Unit::TestCase
  def test_run
    got = []
    Tweemux::Action.stub :explained_run, -> *a { got << a } do
      Tweemux.run %w'host'
    end
    assert_equal [
      %w(tmux -S /tmp/tweemux.sock start-server),
      %w(tmux -S /tmp/tweemux.sock new) + ['tweemux share'],
    ], got.map(&:first)
  end
end
