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
    got = `ruby18 -Ilib -rtweemux -e1`
    fail "ruby18 hates us: #{got}" unless got.empty?
  rescue Errno::ENOENT => e
    # TODO: colorize
    skip <<-EOT if e.message[/ruby18/]
This test needs a 'ruby18' executable in $PATH
If using rbenv, one such script might be:

#!/bin/sh -e
eval "$(rbenv init -)"
rbenv shell 1.8.7-p371
ruby "$@"
    EOT
    raise e
  end

  def ruby18ok args
    "Syntax OK\n" == `ruby18 -c #{args}`
  end
end
