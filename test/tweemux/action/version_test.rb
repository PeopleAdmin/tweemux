require_relative '../../action_test_helper'
class Tweemux::Action
  class VersionTest < MiniTest::Unit::TestCase
    include TweemuxActionHelper
    def argv; %w'version' end
    def expected_commands; [] end
    def test_run
      output = nil
      out, err = capture_io do
        assert_equal stubbed_run.to_yaml, expected_commands.to_yaml
      end
      assert_match Tweemux::VERSION, err
     end
  end

  class DashyVersionFlagTest < VersionTest
    def argv; ['--version'] end
  end

  class VersionShortFlagTest < VersionTest
    def argv; ['-v'] end
  end

  class VersionShortUppercaseFlagTest < VersionTest
    def argv; ['-V'] end
  end
end
