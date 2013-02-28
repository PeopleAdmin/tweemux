require_relative 'test_helper'

class TweemuxTest < MiniTest::Unit::TestCase
  def test_doc_claims
    claimed_working = File.readlines('README.md').grep /^ {4}tweemux/
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

  def test_ruby18
    # TODO: optimize this by running them all in one command
    Dir['{bin,lib}/*.rb'].each do |e|
      fail "ruby18 hates #{e}" unless "Syntax OK\n" == `ruby18 -c #{e}`
    end
  rescue Errno::ENOENT => e
    skip 'Needs ruby18 executable in $PATH' if e.message[/ruby18/]
    raise e
  end
end
