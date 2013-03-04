require_relative 'test_helper'

module TweemuxActionHelper
  def test_run
    assert_equal stubbed_run.to_yaml, expected_commands.to_yaml
  end

  def stubbed_run
    explained_runs = []
    Tweemux::Action.stub :explained_run, -> what, why {
      explained_runs << [ what, why ]
    } do
      Tweemux.run argv
    end
    explained_runs.map &:first # drop the explanations
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
