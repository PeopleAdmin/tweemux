require_relative '../../action_test_helper'
require 'ostruct'

class Tweemux::Action::HubkeyTest < MiniTest::Unit::TestCase
  include TweemuxActionHelper
  def argv; %w(hubkey hi HiOnGithub) end
  def test_run
    commands_run = nil
    with_fake_expand_path expecting: '~hi', expanding_to: '/home/hi' do
      commands_run = stubbed_run
    end
    assert_equal %w(sudo -u hi mkdir -p -m700 /home/hi/.ssh),
      commands_run.shift
    assert_equal %W(
      sudo -u hi
        curl https://github.com/HiOnGithub.keys
         -o /home/hi/.ssh/authorized_keys),
      commands_run.shift
    assert commands_run.empty?, commands_run
  end

  def test_run_will_not_clobber_auth_keys_file
    warning = nil
    with_fake_expand_path expecting: '~hi', expanding_to: '/home/hi' do
      File.stub :exists?, -> path {
        assert_equal '/home/hi/.ssh/authorized_keys', path
        true
      } do
        Tweemux.stub :die, -> msg { warning = msg } do
          stubbed_run
        end
      end
    end
    assert_match /refusing to overwrite.*authorized_keys/i, warning
  end

  def with_fake_expand_path args
    File.stub :expand_path, -> short_path {
      assert_equal args[:expecting], short_path
      args[:expanding_to]
    } do yield end
  end

  def test_no_homedir
    File.stub :expand_path, -> path { raise ArgumentError, 'no such user' } do
      stubbed_run
    end
  rescue Tweemux::Action::NoSuchHomeDir
  else
    fail 'Should be noisy about missing users'
  end

  def test_shorthand_invocation
    action = Tweemux::Action::Hubkey.new :unused
    called = false
    action.stub :run_with_both_usernames, -> {
      called = true
    } do
      action.run 'a'
    end
    assert called
    assert_equal 'a', action.unix_user
    assert_equal 'a', action.github_user
  end
end
