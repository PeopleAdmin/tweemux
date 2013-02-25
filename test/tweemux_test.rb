require_relative 'test_helper'

class TweemuxTest < MiniTest::Unit::TestCase
  def test_doc_claims
    claimed_working = File.readlines('README.rdoc').grep /^ {4}tweemux/
    claimed_working.each do |line|
      line.sub! /#.*/, ''
      fake_argv = line.sub(/^\s*tweemux/, '').split.map{|e| e.strip}
      action = Tweemux.understand fake_argv
      got_run = false
      action.stub :run, -> *a { got_run = true } do
        action.call
      end
      assert got_run, "running action for #{line}"
    end
  end

  def noop
    got = []
    thread_spawned = false
    Tweemux.stub :explained_run, -> *a { got << a } do
      Thread.stub :start, -> { thread_spawned = true } do
        Tweemux.stub :explain, -> *a { } do
          Tweemux.run 'host'
        end
      end
    end
    assert_equal [
      %w(tmux -S /tmp/tweemux.sock start-server),
      %w(tmux -S /tmp/tweemux.sock new-session),
    ], got.map(&:first)
    assert thread_spawned
  end

  def test_explained_run_strictness
    Tweemux.explained_run 'echo > /tmp/hi', 'should not shell-interpret'
  rescue Tweemux::DubiousSystemInvocation
  else
    fail
  end

  def test_ruby18
    Dir['{bin,lib}/*.rb'].each do |e|
      fail "ruby18 hates #{e}" unless "Syntax OK\n" == `ruby18 -c #{e}`
    end
  rescue Errno::ENOENT => e
    skip 'Needs ruby18 executable in $PATH' if e.message[/ruby18/]
    raise e
  end
end
