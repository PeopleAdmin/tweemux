# XXX paste
require_relative '../../test_helper'
class Tweemux::Action::HostTest < MiniTest::Unit::TestCase
  def test_run
    got = []
    Tweemux::Action.stub :explained_run, -> *a { got << a } do
      Tweemux.run %w'share'
    end
    assert_equal [
      %w(chmod a+rw /tmp/tweemux.sock),
      [ENV['SHELL']],
    ], got.map(&:first)
  end
end
