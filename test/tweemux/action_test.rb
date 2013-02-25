require_relative '../test_helper'

class Tweemux::ActionTest < MiniTest::Unit::TestCase
  def test_explained_run_strictness
    Tweemux::Action.explained_run 'echo > /tmp/hi', 'not shell-interpreted'
  rescue Tweemux::Action::DubiousSystemInvocation
  else
    fail 'Should have refused to run a sketchy shell command.'
  end
end
