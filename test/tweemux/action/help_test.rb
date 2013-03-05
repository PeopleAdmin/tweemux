require_relative '../../action_test_helper'
class Tweemux::Action
  class HelpTest < MiniTest::Unit::TestCase
    include TweemuxActionHelper
    def argv; %w'help' end
    def expected_commands; [] end
    def test_run
      output = nil
      out, err = capture_io do
        assert_equal stubbed_run.to_yaml, expected_commands.to_yaml
      end
      assert_match /Guest Usage/i, err
      assert_match /tweemux at/, err
      assert_match /Host Usage/i, err
      assert_match /tweemux host/, err
      refute_match /Problem/i, err
      refute_match /Going Further/i, err
      refute_match /For starters.*gem install tweemux/m, err
    end
  end

  class ImpliedHelp < HelpTest
    def argv; [] end
  end

  class DashyHelp < HelpTest
    def argv; ['--help'] end
  end

  class YouKnowWhatNoDashiesAtAll < HelpTest
    def argv; ['--help'] end
  end
end
