require_relative 'test_helper'

class TweemuxTest < MiniTest::Unit::TestCase
  def test_doc_claims
    claimed_working = File.readlines('README.rdoc').grep /^ {4}tweemux/
    claimed_working.each do |line|
      line.sub! /#.*/, ''
      fake_argv = line.sub(/^\s*tweemux/, '').split.map{|e| e.strip}
      got = Tweemux.understand fake_argv
      assert got, line
    end
  end

  def test_host
    got = []
    Tweemux.stub :explained_run, -> *a { got += a } do
      Tweemux.run 'host'
    end
    assert_equal [
      %w(tmux -S /tmp/tweemux.sock start-server),
      %w(tmux -S /tmp/tweemux.sock new-session),
    ], got
  end
end
