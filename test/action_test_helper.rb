require_relative 'test_helper'

module TweemuxActionHelper
  def test_run
    explained_runs = []
    Tweemux::Action.stub :explained_run, -> *a { explained_runs << a } do
      Tweemux.run argv
    end
    got = explained_runs.map &:first
    assert_equal got.to_yaml, expected_commands.to_yaml
  end

  def bad_runs; [] end
  def test_bad_runs
    bad_runs.each do |illegit|
      begin
        Tweemux.run illegit
      rescue Tweemux::Action::FunkyUsage
      else
        fail "#{illegit} didn't raise expected error"
      end
    end
  end

end
